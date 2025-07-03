import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class GetAllPasswordsUsecase
    extends BaseUseCase<List<Password>, GetAllPasswordsParams> {
  final PasswordRepository repository;
  GetAllPasswordsUsecase(this.repository);

  @override
  FailureOr<List<Password>> call(GetAllPasswordsParams params) =>
      repository.getAllPasswords(params);
}

class GetAllPasswordsParams extends Equatable {
  final int limit;
  final int offset;
  final OrderType order;
  final bool reverse;
  final bool hasArchived;
  final HomePasswordsType passwordsType;

  const GetAllPasswordsParams({
    this.limit = 50,
    this.offset = 0,
    required this.order,
    required this.reverse,
    required this.passwordsType,
    this.hasArchived = false,
  });

  @override
  List<Object?> get props => [
    limit,
    offset,
    order,
    reverse,
    passwordsType,
    hasArchived,
  ];
}
