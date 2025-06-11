import 'package:masterkey_core/src/src.dart';
import 'package:dartz/dartz.dart';

typedef FailureOr<T> = Future<Either<Failure, T>>;

typedef StreamFailureOr<T> = Stream<Either<Failure, T>>;
typedef StreamUpdate = Stream<(int, int)>;

abstract class BaseUseCase<RT, PT> {
  FailureOr<RT> call(PT params);
}

abstract class BaseStreamUsecase<RT, PT> {
  StreamFailureOr<RT> call(PT params);
}

class NoParams {}
