import 'package:dartz/dartz.dart' show Left, Right;
import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

@LazySingleton(as: CardRepository)
class CardRepositoryImpl implements CardRepository {
  final CardLocalDataSource datasource;

  CardRepositoryImpl(this.datasource);

  @override
  FailureOr<List<CardEntity>> getCards(GetCardsParams params) async {
    try {
      final responce = await datasource.getCards(params);
      return Right(responce.map((e) => e.toEntity()).toList());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<CardEntity> createCard(CardModel card) async {
    try {
      final responce = await datasource.createCard(card);
      return Right(responce.toEntity());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<CardEntity> updateCard(CardModel card) async {
    try {
      final responce = await datasource.updateCard(card);
      return Right(responce.toEntity());
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<CardEntity> toggleArchiveCardStatus(
    ToggleArchiveCardParams params,
  ) async {
    try {
      final responce = await datasource.toggleArchiveCardStatus(params);
      return Right(responce.toEntity());
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  FailureOr<bool> deleteCardById(int cardId) async {
    try {
      final responce = await datasource.deleteCardById(cardId);
      return Right(responce);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }
}
