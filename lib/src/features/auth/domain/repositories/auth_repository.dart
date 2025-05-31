import 'package:masterkey_core/src/src.dart';

abstract class AuthRepository {
  FailureOr<User> register(UserModel user);
  FailureOr<User> login(String password);
  StreamFailureOr<Progress> update(UpdateUserParams params);
  FailureOr<User> updateHint(UpdatePasswordHintParams params);
}
