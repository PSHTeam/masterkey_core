import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'package:master_key/src/src.dart';

class MasterKeyEncryptorService {
  static String encryptText(String text) {
    final key = encrypt.Key.fromUtf8(dotenvs.appKey);
    final iv = encrypt.IV.fromUtf8(dotenvs.appIv);
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    return encrypter.encrypt(text, iv: iv).base64;
  }

  static String decryptText(String text) {
    final key = encrypt.Key.fromUtf8(dotenvs.appKey);
    final iv = encrypt.IV.fromUtf8(dotenvs.appIv);
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    return encrypter.decrypt64(text, iv: iv);
  }

  // Function to hash text using SHA-1
  static String hashText(String text) {
    final bytes = utf8.encode(text);
    final digest = sha1.convert(bytes);
    return digest.toString();
  }

  // Function to encrypt text using AES with a fixed output
  static Future<String> encryptTextFixed(String text) async {
    final key = encrypt.Key.fromUtf8(dotenvs.appKey);
    final iv = encrypt.IV.fromUtf8(dotenvs.appIv);
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    return encrypter.encrypt(text, iv: iv).base64;
  }
}
