import 'package:dartz/dartz.dart' show Left, Right;
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  FailureOr<User> register(UserModel user) async {
    try {
      final response = await datasource.register(user);
      return Right(response.toEntity());
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<User> login(String password) async {
    try {
      final response = await datasource.login(password);
      return Right((response.toEntity()));
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(CustomFailure(e.toString()));
    }
  }

  @override
  StreamFailureOr<Progress> update(UpdateUserParams params) async* {
    try {
      final response = datasource.update(params);
      await for (var progress in response) {
        yield Right(progress.toEntity());
      }
    } on Failure catch (failure) {
      yield Left(failure);
    } catch (e) {
      yield Left(CustomFailure(e.toString()));
    }
  }

  @override
  FailureOr<User> updateHint(UpdatePasswordHintParams params) async {
    try {
      final response = await datasource.updateHint(params);
      return Right(response.toEntity());
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(CustomFailure(e.toString()));
    }
  }
}
