import 'dart:convert';
import 'dart:math' show Random;
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart';

/// AES-CBC with per-message salt and IV, and PBKDF2-HMAC-SHA256 key stretching.
class DatabaseEncryptorService {
  /// How many PBKDF2 iterations to use (stretching factor).
  static const int _iterations = 600;

  /// Size of the PBKDF2 salt in bytes.
  static const int _saltBytes = 16;

  /// AES block size / IV length in bytes.
  static const int _ivBytes = 16;

  /// Master key used for encryption/decryption.
  final String masterKey;

  /// Construct with the user’s password (master key).
  const DatabaseEncryptorService(this.masterKey);

  factory DatabaseEncryptorService.initialize(String masterKey) {
    return DatabaseEncryptorService(masterKey);
  }

  /// Encrypts [plaintext] → Base64(salt∥iv∥ciphertext).
  String encrypt(String plaintext) {
    // 1) Fresh salt & derive a 256-bit key from password+salt
    final Uint8List salt = _randomBytes(_saltBytes);
    final Key key = Key(_keyGenerator(masterKey, salt));
    // 2) Fresh IV
    final IV iv = IV.fromSecureRandom(_ivBytes);

    // 3) AES-CBC with PKCS7
    final Encrypter encrypter = Encrypter(
      AES(key, mode: AESMode.cbc, padding: 'PKCS7'),
    );
    final Encrypted cipher = encrypter.encrypt(plaintext, iv: iv);

    // 4) Pack and Base64
    final combined = Uint8List.fromList([
      ...salt,
      ...iv.bytes,
      ...cipher.bytes,
    ]);
    return base64Encode(combined);
  }

  /// Decrypts Base64(salt∥iv∥ciphertext) → plaintext.
  /// Uses PBKDF2-HMAC-SHA256 key stretching.
  String decrypt(String input) {
    // Lagacy method to decryption
    final Uint8List data = base64Decode(input);

    if (data.length < _saltBytes + _ivBytes + 1) {
      throw ArgumentError('Encrypted data too short');
    }

    final Uint8List salt = data.sublist(0, _saltBytes);
    final Uint8List ivBytes = data.sublist(_saltBytes, _saltBytes + _ivBytes);
    final Uint8List cipherBytes = data.sublist(_saltBytes + _ivBytes);

    final Uint8List keyBytes = _keyGenerator(masterKey, salt);
    final Key key = Key(keyBytes);
    final IV iv = IV(ivBytes);

    final Encrypter encrypter = Encrypter(
      AES(key, mode: AESMode.cbc, padding: 'PKCS7'),
    );
    return encrypter.decrypt(Encrypted(cipherBytes), iv: iv);
  }

  String? encryptOrNull(String? text, {bool isPin = false}) {
    if (text == null || text.isEmpty || (isPin && int.parse(text) == 0)) {
      return null;
    }
    return encrypt(text);
  }

  String? decryptOrNull(String? text, {bool isPin = false}) {
    if (text == null || text.isEmpty || (isPin && int.parse(text) == 0)) {
      return null;
    }
    return decrypt(text);
  }

  /// Derive a 32-byte key via PBKDF2-HMAC-SHA256.
  static Uint8List _keyGenerator(String pass, Uint8List salt) {
    final hmac = HMac(SHA256Digest(), 64);
    final PBKDF2KeyDerivator derivator = PBKDF2KeyDerivator(hmac)
      ..init(Pbkdf2Parameters(salt, _iterations, 32));
    return derivator.process(Uint8List.fromList(utf8.encode(pass)));
  }

  /// Cryptographically-secure random bytes.
  static Uint8List _randomBytes(int len) {
    final rnd = Random.secure();
    return Uint8List.fromList(List<int>.generate(len, (_) => rnd.nextInt(256)));
  }
}
