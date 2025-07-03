import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class Toggle2FAUsecase extends BaseUseCase<Password, Toggle2FAParams> {
  final PasswordRepository repository;
  Toggle2FAUsecase(this.repository);

  @override
  FailureOr<Password> call(Toggle2FAParams params) async =>
      await repository.toggle2FA(params);
}

class Toggle2FAParams extends Equatable {
  final int id;
  final bool status;
  final String authKey;

  const Toggle2FAParams({
    required this.id,
    required this.status,
    required this.authKey,
  });

  Toggle2FAParams copyWith({int? id, bool? status, String? authKey}) {
    return Toggle2FAParams(
      id: id ?? this.id,
      status: status ?? this.status,
      authKey: authKey ?? this.authKey,
    );
  }

  @override
  List<Object?> get props => [id, status, authKey];
}
