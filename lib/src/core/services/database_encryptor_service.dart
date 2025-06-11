import 'dart:convert';
import 'dart:developer' show log;
import 'dart:isolate';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' show sha256;
import 'package:cryptography_plus/cryptography_plus.dart'
    show AesCbc, Hmac, SecretKey, SecretBox, Pbkdf2;

import 'package:masterkey_core/src/src.dart';

/// The `DatabaseEncryptorService` encapsulates the logic for deriving the encryption key
/// from the Master Password and performing encryption and decryption operations.
/// It aims to provide quantum-level difficulty for unauthorized access, meaning
/// breaking the encryption would require computational power not yet publicly available.
class DatabaseEncryptorService {
  // AES block size = 128 bits = 16 bytes. Used for the nonce/IV.
  static const int _nonceLength = 16;
  // HMAC-SHA256 produces a 32-byte MAC (Message Authentication Code).
  static const int _macLength = 32;

  /// The user's master password. This is NEVER stored persistently.
  /// It's held in memory only for the duration of the session.
  final String masterKey;

  /// The derived cryptographic key bytes from the [masterKey] via PBKDF2.
  /// This key is used for AES encryption/decryption.
  final Uint8List keyBytes;

  /// AES-CBC encryption algorithm configured with 256-bit keys and HMAC-SHA256 for MAC.
  final AesCbc encrypter;

  /// Constructs the `DatabaseEncryptorService` with the user’s [masterKey]
  /// and the derived cryptographic materials ([keyBytes], [encrypter]).
  /// This constructor is typically called by the [initialize] method.
  const DatabaseEncryptorService(
    this.masterKey,
    this.keyBytes,
    this.encrypter,
  );

  /// Initializes the `DatabaseEncryptorService` by deriving the encryption key
  /// from the provided [masterKey].
  ///
  /// This process involves:
  /// 1. Deterministically generating a salt from `dotenv.appKey` (application-specific key).
  ///    This salt is used in the key derivation process.
  /// 2. Deriving a 256-bit cryptographic key from the [masterKey] and the salt using
  ///    PBKDF2 with HMAC-SHA256 and 120,000 iterations. This is computationally
  ///    intensive to protect against brute-force attacks. The derivation is performed
  ///    in a separate Isolate to avoid blocking the main UI thread.
  /// 3. Configuring AES-CBC with 256-bit keys and HMAC-SHA256 for message authentication.
  static Future<DatabaseEncryptorService> initialize(String masterKey) async {
    // Derive a 16-byte salt deterministically from a global application key (dotenv.appKey).
    // This ensures that the salt is consistent for the same app installation but
    // adds a layer of protection.
    // Use the first 16 bytes of the hash as the nonce for PBKDF2.
    final Uint8List nonceBytes = Uint8List.fromList(
      sha256.convert(utf8.encode(dotenvs.appKey)).bytes,
    ).sublist(0, _nonceLength);
    // Derive the encryption key from the masterKey and saltBytes using PBKDF2.
    // This is done in an Isolate to prevent UI jank due to the intensive computation.
    final Uint8List keyBytes = await deriveKeyInIsolate(masterKey, nonceBytes);

    final algorithm = AesCbc.with256bits(
      macAlgorithm: Hmac.sha256(), // CBC mode requires its own MAC for integrity.
    );
    return DatabaseEncryptorService(masterKey, keyBytes, algorithm);
  }

  /// Encrypts the given [plaintext] string.
  ///
  /// The process involves:
  /// 1. Generating a new unique 16-byte nonce (IV) for each encryption.
  /// 2. Encrypting the [plaintext] (UTF-8 encoded) using AES-CBC with the derived [keyBytes] and the generated nonce.
  /// 3. Concatenating the nonce, ciphertext, and MAC (Message Authentication Code).
  /// 4. Encoding the combined byte array into a Base64 string for storage.
  ///
  /// The output format is: Base64(nonce ∥ ciphertext ∥ MAC).
  Future<String> encrypt(String plaintext) async {
    // Generate a new, cryptographically secure random nonce (IV) for each encryption.
    final nonce = encrypter.newNonce(); // List<int> of length 16

    // Encrypt the plaintext using AES-CBC.
    // The secretKey is the key derived via PBKDF2.
    final encrypted = await encrypter.encrypt(
      utf8.encode(plaintext),
      secretKey: SecretKey(keyBytes),
      nonce: nonce, // Provide the unique nonce for this encryption.
    );

    // Pack the nonce, ciphertext, and MAC together.
    // The nonce is prepended to the ciphertext to be used during decryption.
    // The MAC is appended to verify integrity and authenticity.
    final combined = Uint8List.fromList([
      ...encrypted.nonce, // 16-byte Nonce (IV)
      ...encrypted.cipherText, // Actual encrypted data
      ...encrypted.mac.bytes, // 32-byte HMAC-SHA256
    ]);
    // Encode the combined bytes as a Base64 string for easy storage.
    return base64Encode(combined);
  }

  /// Decrypts a Base64 encoded string, previously encrypted by the [encrypt] method.
  ///
  /// The input string is expected to be in the format: Base64(nonce ∥ ciphertext ∥ MAC).
  ///
  /// The process involves:
  /// 1. Decoding the Base64 [input] string.
  /// 2. Extracting the nonce, ciphertext, and MAC from the decoded bytes.
  /// 3. Decrypting the ciphertext using AES-CBC with the derived [keyBytes], the extracted nonce,
  ///    and verifying the MAC.
  /// 4. Decoding the resulting plaintext bytes back into a UTF-8 string.
  ///
  /// Uses PBKDF2-HMAC-SHA256 key stretching implicitly via the initialized [keyBytes].
  Future<String> decrypt(String input) async {
    try {
      // Decode the Base64 input string back into bytes.
    final Uint8List blob = base64Decode(input);

    // Basic check to ensure the data is not obviously too short to contain nonce + MAC + at least 1 byte of data.
    if (blob.length < _nonceLength + _macLength + 1) {
      throw ArgumentError(
          'Encrypted data too short to be valid. Must contain nonce, MAC, and ciphertext.');
    }

    // Use SecretBox.fromConcatenation to parse the combined (nonce || ciphertext || mac) bytes.
    // This utility helps separate the components.
    final secretBox = SecretBox.fromConcatenation(
      blob,
      nonceLength: _nonceLength, // Expected length of the nonce (IV)
      macLength: _macLength, // Expected length of the MAC
      copy: false, // Avoid unnecessary copying of data
    );

    // Decrypt the ciphertext using the same secretKey (derived via PBKDF2) and the extracted nonce.
    // The MAC is automatically verified during decryption. If tampered, it will throw an error.
    final plaintext = await encrypter.decrypt(
      secretBox,
      secretKey: SecretKey(keyBytes),
    );
    // Decode the decrypted bytes (UTF-8) back into a String.
    return utf8.decode(plaintext);
    } catch (e, s) {
      log('Decryption failed: $e',
          error: e, stackTrace: s, name: 'decrypt');
      // It's generally better to throw a more specific error type or re-throw
      // the original error if the caller is expected to handle different crypto errors.
      throw CustomFailure('Decryption failed. Data might be corrupt or the master key is incorrect. Original error: ${e.toString()}');
    }
  }

  /// Encrypts the given [text] if it's not null or empty.
  /// If [isPin] is true and the text represents "0", it's treated as empty.
  /// Returns `null` if the input [text] is null, empty, or a "0" pin.
  /// Otherwise, returns the encrypted string.
  Future<String?> encryptOrNull(String? text, {bool isPin = false}) async {
    if (text == null || text.isEmpty || (isPin && int.tryParse(text) == 0)) {
      return null;
    }
    return encrypt(text);
  }

  /// Decrypts the given [text] if it's not null or empty.
  /// If [isPin] is true and the text represents "0" (though an encrypted "0" pin is unlikely),
  /// it's treated as empty.
  /// Returns `null` if the input [text] is null or empty.
  /// Otherwise, returns the decrypted string.
  Future<String?> decryptOrNull(String? text, {bool isPin = false}) async {
    if (text == null || text.isEmpty || (isPin && text == "0")) { // A "0" pin would be encrypted, so this check might be redundant for encrypted text.
      return null;
    }
    return decrypt(text);
  }
}

/// Helper class to pass arguments to the Isolate for key derivation.
class _Args {
  final String password;
  final Uint8List salt;
  final SendPort reply;
  _Args(this.password, this.salt, this.reply);
}

/// Worker function executed in a separate Isolate to perform PBKDF2 key derivation.
/// This prevents the computationally intensive task from blocking the main UI thread.
///
/// [args] contains the user's password, salt, and a SendPort to return the derived key.
Future<void> _worker(_Args args) async {
  // Configure PBKDF2:
  // - HMAC-SHA256 as the underlying pseudo-random function.
  // - 120,000 iterations: A common recommendation for balancing security and performance.
  //   Higher iterations make brute-force attacks much harder.
  // - 256 bits (32 bytes): The desired length of the derived key, matching AES-256.
  final pbkdf2 = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 120_000, // High iteration count for security
    bits: 256, // Output key length in bits (32 bytes)
  );

  // Derive the key from the user's password (as a SecretKey) and the provided salt.
  final secretKey = await pbkdf2.deriveKey(
    secretKey: SecretKey(utf8.encode(args.password)), // Password bytes
    nonce: args.salt, // Salt bytes
  );

  // Extract the raw key material (bytes) from the SecretKey object.
  final keyMaterial = Uint8List.fromList(await secretKey.extractBytes());
  // Send the derived key bytes back to the main isolate.
  args.reply.send(keyMaterial);
}

/// Derives a cryptographic key from the [password] and [salt] using PBKDF2
/// in a separate Isolate to avoid blocking the main thread.
///
/// Returns the derived key as a [Uint8List].
Future<Uint8List> deriveKeyInIsolate(String password, Uint8List salt) async {
  final rp = ReceivePort();
  // Spawn an Isolate to run the _worker function with the provided arguments.
  await Isolate.spawn(_worker, _Args(password, salt, rp.sendPort));

  // Wait for the Isolate to send back the derived key bytes.
  final Uint8List keyBytes = await rp.first as Uint8List;
  rp.close(); // Close the receive port once the data is received.
  return keyBytes;
}
