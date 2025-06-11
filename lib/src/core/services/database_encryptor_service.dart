import 'dart:convert';
import 'dart:developer' show log;
import 'dart:isolate';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' show sha256;
import 'package:cryptography_plus/cryptography_plus.dart'
    show AesCbc, Hmac, SecretKey, SecretBox, Pbkdf2;

import 'package:masterkey_core/src/src.dart';

/// AES-CBC with per-message salt and IV, and PBKDF2-HMAC-SHA256 key stretching.
class DatabaseEncryptorService {
  // AES block size = 128 bits = 16 bytes
  static const int _nonceLength = 16;
  // HMAC-SHA256 produces 32 bytes
  static const int _macLength = 32;

  /// Master key used for encryption/decryption.
  final String masterKey;

  final Uint8List keyBytes;
  final Hmac hmac;
  final AesCbc encrypter;

  /// Construct with the user’s password (master key).
  const DatabaseEncryptorService(
    this.masterKey,
    this.keyBytes,
    this.hmac,
    this.encrypter,
  );

  static Future<DatabaseEncryptorService> initialize(String masterKey) async {
    // ── Derive a 16-byte salt deterministically from dotenv.appKey:
    final Uint8List fullHash = Uint8List.fromList(
      sha256.convert(utf8.encode(dotenvs.appKey)).bytes,
    );
    final Uint8List saltBytes = fullHash.sublist(0, _nonceLength);
    final Uint8List keyBytes = await deriveKeyInIsolate(masterKey, saltBytes);
    final Hmac hmac = Hmac.sha256();
    final algorithm = AesCbc.with256bits(
      macAlgorithm: hmac,
    ); // CBC needs its own MAC
    return DatabaseEncryptorService(masterKey, keyBytes, hmac, algorithm);
  }

  /// Encrypts [plaintext] → Base64(salt∥ciphertext).
  Future<String> encrypt(String plaintext) async {
    final nonce = encrypter.newNonce(); // List<int> of length 16
    final encrypted = await encrypter.encrypt(
      utf8.encode(plaintext),
      secretKey: SecretKey(keyBytes),
      nonce: nonce,
    );

    // 3) Pack and Base64
    final combined = Uint8List.fromList([
      ...encrypted.nonce, // 16-byte IV
      ...encrypted.cipherText,
      ...encrypted.mac.bytes,
    ]);
    return base64Encode(combined);
  }

  /// Decrypts Base64(salt∥iv∥ciphertext) → plaintext.
  /// Uses PBKDF2-HMAC-SHA256 key stretching.
  Future<String> decryptText(String input) async {
    final Uint8List blob = base64Decode(input);

    if (blob.length < _nonceLength + 1) {
      throw ArgumentError('Encrypted data too short');
    }

    final secretBox = SecretBox.fromConcatenation(
      blob,
      nonceLength: _nonceLength,
      macLength: _macLength,
      copy: false,
    );

    final plaintext = await encrypter.decrypt(
      secretBox,
      secretKey: SecretKey(keyBytes),
    );
    return utf8.decode(plaintext);
  }

  /// Uses legacy and new methods for decryption.
  Future<String> decrypt(String input, {bool restore = false}) async {
    try {
      return await decryptText(input);
    } catch (e, s) {
      log('decryption: $e', error: e, stackTrace: s, name: 'decrypt');
      throw CustomFailure(e.toString());
    }
  }

  Future<String?> encryptOrNull(String? text, {bool isPin = false}) async {
    if (text == null || text.isEmpty || (isPin && int.parse(text) == 0)) {
      return null;
    }
    return encrypt(text);
  }

  Future<String?> decryptOrNull(String? text, {bool isPin = false}) async {
    if (text == null || text.isEmpty || (isPin && int.parse(text) == 0)) {
      return null;
    }
    return decrypt(text);
  }
}

class _Args {
  final String password;
  final Uint8List salt;
  final SendPort reply;
  _Args(this.password, this.salt, this.reply);
}

Future<void> _worker(_Args args) async {
  final pbkdf2 = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 120_000,
    bits: 256,
  );

  final secretKey = await pbkdf2.deriveKey(
    secretKey: SecretKey(utf8.encode(args.password)),
    nonce: args.salt,
  );

  // SensitiveBytes → Uint8List
  final keyMaterial = Uint8List.fromList(await secretKey.extractBytes());
  args.reply.send(keyMaterial);
}

Future<Uint8List> deriveKeyInIsolate(String password, Uint8List salt) async {
  final rp = ReceivePort();
  await Isolate.spawn(_worker, _Args(password, salt, rp.sendPort));

  final Uint8List keyBytes = await rp.first as Uint8List;
  return keyBytes;
}
