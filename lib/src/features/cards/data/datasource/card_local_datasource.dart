import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

abstract class CardLocalDataSource {
  Future<List<CardModel>> getCards(GetCardsParams params);
  Future<CardModel> createCard(CardModel card);
  Future<CardModel> updateCard(CardModel card);
  Future<CardModel> toggleArchiveCardStatus(ToggleArchiveCardParams card);
  Future<bool> deleteCardById(int id);
}

@LazySingleton(as: CardLocalDataSource)
class CardLocalDataSourceImpl implements CardLocalDataSource {
  final AppDatabaseWrapper appDatabase;

  CardLocalDataSourceImpl(this.appDatabase);

  @override
  Future<List<CardModel>> getCards(GetCardsParams params) async {
    final cardTableData = await appDatabase.db.cardDao.getCards(params);
    final cards = await Future.wait(
      cardTableData.map((card) async {
        final fields = await appDatabase.db.cardDao.getCardFields(card.id);
        return CardModel.fromTableData(card, fields: fields);
      }).toList(),
    );
    return cards;
  }

  @override
  Future<CardModel> createCard(CardModel card) async {
    try {
      final newCard = await appDatabase.db.cardDao.insertCard(card);
      final cardFieldData = await appDatabase.db.cardDao.getCardFields(newCard.id);

      return CardModel.fromTableData(newCard, fields: cardFieldData);
    } catch (e) {
      throw CustomFailure(e.toString());
    }
  }

  @override
  Future<CardModel> updateCard(CardModel card) async {
    final updateId = await appDatabase.db.cardDao.updateCard(card: card);
    if (updateId == 0) throw UnknownFailure();

    final cardTableData = await appDatabase.db.cardDao.getCard(card.id!);
    if (cardTableData == null) throw NotFoundFailure();
    // final cardFieldData = await appDatabase.db.cardDao.getCardFields(card.id!);
    return CardModel.fromTableData(cardTableData, fields: []);
  }

  @override
  Future<CardModel> toggleArchiveCardStatus(
    ToggleArchiveCardParams params,
  ) async {
    final updateId = await appDatabase.db.cardDao.toggleArchiveCardStatus(
      id: params.id,
      status: params.status,
    );

    if (updateId == 0) throw UnknownFailure();

    final cardData = await appDatabase.db.cardDao.getCard(params.id);
    final cardFieldData = await appDatabase.db.cardDao.getCardFields(params.id);
    return CardModel.fromTableData(cardData!, fields: cardFieldData);
  }

  @override
  Future<bool> deleteCardById(int id) async {
    final deleteId = await appDatabase.db.cardDao.deleteCard(id);
    if (deleteId == 0) throw UnknownFailure();

    return deleteId > 0;
  }
}
