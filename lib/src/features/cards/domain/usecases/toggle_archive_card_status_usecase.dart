import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@lazySingleton
class ToggleArchiveCardStatusUsecase
    extends BaseUseCase<CardEntity, ToggleArchiveCardParams> {
  final CardRepository repo;
  ToggleArchiveCardStatusUsecase(this.repo);

  @override
  FailureOr<CardEntity> call(ToggleArchiveCardParams params) =>
      repo.toggleArchiveCardStatus(params);
}

class ToggleArchiveCardParams extends Equatable {
  final int id;
  final bool status;

  const ToggleArchiveCardParams({required this.id, required this.status});

  @override
  List<Object?> get props => [id, status];
}
