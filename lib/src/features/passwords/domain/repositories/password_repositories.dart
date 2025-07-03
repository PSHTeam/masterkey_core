import 'package:masterkey_core/src/src.dart';

abstract class PasswordRepository {
  FailureOr<List<Password>> getAllPasswords(GetAllPasswordsParams params);
  FailureOr<Password> addPassword(PasswordModel password);
  FailureOr<Password> updatePassword(UpdatePasswordParams params);
  FailureOr<bool> deletePassword(int passwordId);
  FailureOr<bool> deletePasswords(NoParams params);

  FailureOr<Password> toggle2FA(Toggle2FAParams params);
  FailureOr<Password> toggleArchiveStatus(TogglePasswordArchiveParams params);
}
