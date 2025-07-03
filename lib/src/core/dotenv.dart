abstract class Dotenv {
  /// A secret key for encrypting the master password.
  ///
  /// This is used with [appIv] to encrypt the master password before it's
  /// hashed and stored.
  ///
  /// We use the appKey also as a nonce when encrypting to make the encrypted
  /// data more secure and hard to decrypt. If you only have the master
  /// password, you will need to reverse engineer the app to also get the
  /// appKey to be able to decrypt the data.
  String get appKey;

  /// The Initialization Vector (IV) for master password encryption.
  String get appIv;
}
