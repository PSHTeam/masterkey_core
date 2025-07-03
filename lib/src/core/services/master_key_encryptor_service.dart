import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'package:masterkey_core/dependency_injection.dart';
import 'package:masterkey_core/src/src.dart';

/// Manages the encryption and hashing of the user's master password.
///
/// This service is used when a user creates a new master password or when they
/// log in. It provides a secure way to handle and verify the master password
/// without ever storing it directly on the device.
///
/// ### Master Password Creation and Storage
///
/// When a user creates their master password, the following steps are taken:
/// 1. The plain-text master password is encrypted using the app's secret
///    `appKey` and `appIv`.
/// 2. A hash is then generated from this newly **encrypted** password.
/// 3. This final hash is what gets stored in the local storage.
///
/// ### Security Rationale
///
/// **Why encrypt before hashing?**
///
/// This two-step process adds a crucial layer of protection. By first
/// encrypting the password with a key unknown to an attacker, we effectively
/// "pepper" the input before hashing. This makes it incredibly difficult to use
/// brute-force tools or rainbow tables against the hash, even if an attacker
/// gains access to the locally stored hash.
///
/// The user's master password is **never** stored on the device; it only exists
/// in memory during the session.
///
/// **Why store the hash?**
///
/// The hash is stored as a secure verification token. When the user logs in
/// again, we perform the same encrypt-then-hash process on the password they
/// enter. If the resulting hash matches the one stored locally, we can confirm
/// they have provided the correct master password without ever having to store or
/// compare the plain-text password itself.
class MasterKeyEncryptorService {
  static String encryptText(String text) {
    final Dotenv dotenv = sl<Dotenv>();
    final key = encrypt.Key.fromUtf8(dotenv.appKey);
    final iv = encrypt.IV.fromUtf8(dotenv.appIv);
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    return encrypter.encrypt(text, iv: iv).base64;
  }

  static String decryptText(String text) {
    final Dotenv dotenv = sl<Dotenv>();
    final key = encrypt.Key.fromUtf8(dotenv.appKey);
    final iv = encrypt.IV.fromUtf8(dotenv.appIv);
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    return encrypter.decrypt64(text, iv: iv);
  }

  static String hashText(String text) {
    final bytes = utf8.encode(text);
    final digest = sha1.convert(bytes);
    return digest.toString();
  }

  static Future<String> encryptTextFixed(String text) async {
    final Dotenv dotenv = sl<Dotenv>();
    final key = encrypt.Key.fromUtf8(dotenv.appKey);
    final iv = encrypt.IV.fromUtf8(dotenv.appIv);
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    return encrypter.encrypt(text, iv: iv).base64;
  }
}
