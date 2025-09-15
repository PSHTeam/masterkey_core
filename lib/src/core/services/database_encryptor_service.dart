import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' show sha256;
import 'package:cryptography_plus/cryptography_plus.dart'
    show AesCbc, Hmac, SecretKey, SecretBox, Pbkdf2;
import 'package:masterkey_core/dependency_injection.dart';

import 'package:masterkey_core/src/src.dart';

/// A service responsible for encrypting and decrypting all sensitive data within the app.
///
/// At the core of the app's security model is the user's **master password**.
/// This service uses the master password to derive a strong encryption key,
/// ensuring that all user data (passwords, cards and wallets) is stored securely in
/// the local database and is inaccessible without this primary secret.
///
/// To achieve robust security, the encryption process employs a multi-layered
/// defense strategy centered around the master password:
///
/// 1.  **Master Password Key Derivation (PBKDF2)**: The master password is the
///     essential first ingredient. It is processed through the computationally
///     intensive PBKDF2 algorithm to produce a strong cryptographic key. This
///     key stretching makes brute-force attacks against the master password
///     infeasible.
///
/// 2.  **Application-Specific Salting**: To further strengthen the derived key,
///     a secret `appKey` (unique to the application) is used as a salt in the
///     PBKDF2 process. This adds a critical layer of protection. It means that
///     even if an attacker has the user's master password and the encrypted
///     database, they still cannot decrypt the data without also reverse-
///     engineering the application to find the `appKey`.
///
/// 3.  **Authenticated Encryption (AES-256-CBC with HMAC-SHA256)**: The final
///     derived key is used to encrypt the data with AES-256. Each encrypted
///     item is also signed with an HMAC, which prevents tampering and ensures
///     data integrity.
///
/// This design ensures that the master password remains the single point of
/// authority, while the architecture provides formidable protection against a
/// wide range of attacks, including those involving direct access to the device's
/// file system.
class DatabaseEncryptorService {
  /// The length of the nonce (IV) for AES-CBC, in bytes.
  static const int _nonceLength = 16;

  /// The length of the HMAC-SHA256 MAC, in bytes.
  static const int _macLength = 32;

  /// The user's raw master password. Kept for potential re-authentication needs.
  final String masterKey;

  /// The strong cryptographic key derived from the user's master password and
  /// the app-specific salt. This key is used for all encryption and decryption
  /// operations.
  final Uint8List obfuscatedMasterKey;

  /// The AES-CBC encryption algorithm instance.
  final AesCbc encrypter;

  const DatabaseEncryptorService(
    this.masterKey,
    this.obfuscatedMasterKey,
    this.encrypter,
  );

  /// Initializes the service by deriving the encryption key from the master password.
  ///
  /// This factory is the standard way to create an instance of the service.
  /// It performs the computationally expensive key derivation in a separate
  /// isolate to avoid blocking the main UI thread.
  static Future<DatabaseEncryptorService> initialize(String masterKey) async {
    final dotenv = sl<Dotenv>();

    // Derive a salt from the secret appKey. This ensures that the derived key is
    // unique to this application instance.
    final Uint8List salt = Uint8List.fromList(
      sha256.convert(utf8.encode(dotenv.appKey)).bytes,
    ).sublist(0, _nonceLength);

    // Perform the expensive key derivation in a background isolate.
    final Uint8List keyBytes = await deriveKeyInIsolate(masterKey, salt);

    final algorithm = AesCbc.with256bits(macAlgorithm: Hmac.sha256());
    return DatabaseEncryptorService(masterKey, keyBytes, algorithm);
  }

  /// Encrypts the given plaintext string.
  ///
  /// The encryption process generates a new random nonce for each operation.
  /// The final output is a Base64 encoded string containing the nonce,
  /// cipherText, and authentication MAC, concatenated in that order.
  /// `[nonce][cipherText][mac]`
  Future<String> encrypt(String plaintext) async {
    final nonce = encrypter.newNonce();

    final encrypted = await encrypter.encrypt(
      utf8.encode(plaintext),
      secretKey: SecretKey(obfuscatedMasterKey),
      nonce: nonce,
    );

    // Concatenate nonce, cipherText, and MAC for storage.
    final combined = Uint8List.fromList([
      ...encrypted.nonce,
      ...encrypted.cipherText,
      ...encrypted.mac.bytes,
    ]);
    return base64Encode(combined);
  }

  /// Decrypts the given Base64 encoded string.
  ///
  /// This method decodes the input, separates the nonce, cipherText, and MAC,
  /// and then attempts to decrypt the data. The MAC is automatically verified
  /// during decryption, ensuring data integrity.
  ///
  /// Throws a [CustomFailure] if decryption fails, which can happen if the
  /// master key is incorrect or the data has been tampered with.
  Future<String> decrypt(String input) async {
    try {
      final Uint8List blob = base64Decode(input);

      // Basic validation to ensure the data is long enough to be valid.
      if (blob.length < _nonceLength + _macLength + 1) {
        throw ArgumentError(
          'Encrypted data too short to be valid. Must contain nonce, MAC, and cipherText.',
        );
      }

      // Reconstruct the SecretBox from the concatenated parts.
      final secretBox = SecretBox.fromConcatenation(
        blob,
        nonceLength: _nonceLength,
        macLength: _macLength,
        copy: false,
      );

      final plaintext = await encrypter.decrypt(
        secretBox,
        secretKey: SecretKey(obfuscatedMasterKey),
      );
      return utf8.decode(plaintext);
    } catch (e) {
      throw CustomFailure(
        'Decryption failed. Data might be corrupt or the master key is incorrect. Original error: ${e.toString()}',
      );
    }
  }

  /// A convenience method to encrypt a nullable string.
  /// Returns `null` if the input is null, empty, or represents a PIN with value 0.
  Future<String?> encryptOrNull(String? text, {bool isPin = false}) async {
    if (text == null || text.isEmpty || (isPin && int.tryParse(text) == 0)) {
      return null;
    }
    return encrypt(text);
  }

  /// A convenience method to decrypt a nullable string.
  /// Returns `null` if the input is null, empty, or represents a PIN with value "0".
  Future<String?> decryptOrNull(String? text, {bool isPin = false}) async {
    if (text == null || text.isEmpty || (isPin && text == "0")) {
      return null;
    }
    return decrypt(text);
  }
}

/// A data class to pass arguments to the isolate for key derivation.
class _Args {
  final String password;
  final Uint8List salt;
  final SendPort reply;
  _Args(this.password, this.salt, this.reply);
}

/// The worker function that runs in the isolate to perform key derivation.
///
/// This function uses PBKDF2 to derive a strong key from the user's password.
/// Running this in an isolate prevents the UI from freezing during the
/// computationally expensive operation.
Future<void> _worker(_Args args) async {
  final pbkdf2 = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 120_000, // A high number of iterations to slow down attackers.
    bits: 256, // Derives a 256-bit (32-byte) key.
  );

  final secretKey = await pbkdf2.deriveKey(
    secretKey: SecretKey(utf8.encode(args.password)),
    nonce: args.salt,
  );

  final keyMaterial = Uint8List.fromList(await secretKey.extractBytes());
  args.reply.send(keyMaterial);
}

/// Spawns an isolate to derive a key from a password and salt.
///
/// This is the public-facing function to start the key derivation process in
/// the background.
Future<Uint8List> deriveKeyInIsolate(String password, Uint8List salt) async {
  final rp = ReceivePort();
  await Isolate.spawn(_worker, _Args(password, salt, rp.sendPort));

  final Uint8List keyBytes = await rp.first as Uint8List;
  rp.close();
  return keyBytes;
}
