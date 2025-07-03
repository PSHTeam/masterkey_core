import 'package:masterkey_core/src/src.dart';

abstract class CardRepository {
  FailureOr<List<CardEntity>> getCards(GetCardsParams params);
  FailureOr<CardEntity> createCard(CardModel params);
  FailureOr<CardEntity> updateCard(CardModel params);
  FailureOr<CardEntity> toggleArchiveCardStatus(ToggleArchiveCardParams params);
  FailureOr<bool> deleteCardById(int paramsId);
}
