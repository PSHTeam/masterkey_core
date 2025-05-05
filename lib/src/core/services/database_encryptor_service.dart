import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';

class DatabaseEncryptorService {
  final encrypt.Encrypter encrypter;
  final encrypt.IV iv;
  final String masterKey;

  DatabaseEncryptorService(this.encrypter, this.iv, this.masterKey);

  factory DatabaseEncryptorService.initialize(String masterKey) {
    final key = encrypt.Key.fromUtf8(
      sha256.convert(utf8.encode(masterKey)).toString().substring(0, 32),
    );
    final iv = encrypt.IV.fromUtf8(
      sha256.convert(utf8.encode(masterKey)).toString().substring(0, 16),
    );
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    return DatabaseEncryptorService(encrypter, iv, masterKey);
  }

  String encryptText(String text) {
    return encrypter.encrypt(text, iv: iv).base64;
  }

  String? encryptTextOrNull(String? text, {bool isPin = false}) {
    if (text == null || text.isEmpty || (isPin && int.parse(text) == 0)) {
      return null;
    }
    return encrypter.encrypt(text, iv: iv).base64;
  }

  String? decryptTextOrNull(String? text, {bool isPin = false}) {
    if (text == null || text.isEmpty || (isPin && int.parse(text) == 0)) {
      return null;
    }
    return encrypter.encrypt(text, iv: iv).base64;
  }

  String decryptText(String text) {
    return encrypter.decrypt64(text, iv: iv);
  }

  List<int> encryptBytes(List<int> data) {
    final encrypted = encrypter.encryptBytes(data, iv: iv);
    return encrypted.bytes;
  }

  List<int> decryptBytes(List<int> data) {
    try {
      // log('Data length: ${data.length}');
      final encryptedData = encrypt.Encrypted(Uint8List.fromList(data));
      final decrypted = encrypter.decryptBytes(encryptedData, iv: iv);
      return decrypted;
    } catch (e) {
      // log('Decryption error: $e');
      throw ArgumentError('Invalid or corrupted pad block: $e');
    }
  }
}
