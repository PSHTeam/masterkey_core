import 'package:injectable/injectable.dart';
import 'package:masterkey_core/src/src.dart';

abstract class CardLocalDataSource {
  Future<List<CardModel>> getCards(GetCardsParams params);
  Future<CardModel> getCard(int id);
  Future<CardModel> createCard(CardModel card);
  Future<CardModel> updateCard(CardModel card);
  Future<CardModel> toggleArchiveCardStatus(ToggleArchiveCardParams card);
  Future<bool> deleteCardById(int id);
  Future<List<CardModel>> searchCards(SearchCardParams params);
}

@LazySingleton(as: CardLocalDataSource)
class CardLocalDataSourceImpl implements CardLocalDataSource {
  final AppDatabase appDatabase;

  CardLocalDataSourceImpl(this.appDatabase);

  @override
  Future<List<CardModel>> getCards(GetCardsParams params) async {
    final cardTableData = await appDatabase.cardDao.getCards(params);
    final cards = await Future.wait(
      cardTableData.map((card) async {
        final fields = await appDatabase.cardDao.getCardFields(card.id);
        return CardModel.fromTableData(card, fields: fields);
      }).toList(),
    );
    return cards;
  }

  @override
  Future<CardModel> getCard(int id) async {
    final card = await appDatabase.cardDao.getCard(id);
    if (card == null) {
      throw UnknownFailure();
    } else {
      final fields = await appDatabase.cardDao.getCardFields(id);
      return CardModel.fromTableData(card, fields: fields);
    }
  }

  @override
  Future<CardModel> createCard(CardModel card) async {
    try {
      final newCard = await appDatabase.cardDao.insertCard(card);
      final cardFieldData = await appDatabase.cardDao.getCardFields(newCard.id);

      return CardModel.fromTableData(newCard, fields: cardFieldData);
    } catch (e) {
      // log(e.toString());
      throw CustomFailure(e.toString());
    }
  }

  @override
  Future<CardModel> updateCard(CardModel card) async {
    // log('Updating card: $card');
    final updateId = await appDatabase.cardDao.updateCard(card: card);
    if (updateId == 0) throw UnknownFailure();

    final cardTableData = await appDatabase.cardDao.getCard(card.id!);
    if (cardTableData == null) throw NotFoundFailure();
    // final cardFieldData = await appDatabase.cardDao.getCardFields(card.id!);
    return CardModel.fromTableData(cardTableData, fields: []);
  }

  @override
  Future<CardModel> toggleArchiveCardStatus(
    ToggleArchiveCardParams params,
  ) async {
    final updateId = await appDatabase.cardDao.toggleArchiveCardStatus(
      id: params.id,
      status: params.status,
    );

    if (updateId == 0) throw UnknownFailure();

    final cardData = await appDatabase.cardDao.getCard(params.id);
    final cardFieldData = await appDatabase.cardDao.getCardFields(params.id);
    return CardModel.fromTableData(cardData!, fields: cardFieldData);
  }

  @override
  Future<bool> deleteCardById(int id) async {
    final deleteId = await appDatabase.cardDao.deleteCard(id);
    if (deleteId == 0) throw UnknownFailure();

    return deleteId > 0;
  }

  @override
  Future<List<CardModel>> searchCards(SearchCardParams params) async {
    final searchQuery = params.query;
    final limit = params.limit;
    final offset = params.offset;

    final data = await appDatabase.cardDao.searchCards(
      searchQuery,
      limit: limit,
      offset: offset,
    );

    final response = [
      for (CardTableData card in data)
        CardModel.fromTableData(
          card,
          fields: await appDatabase.cardDao.getCardFields(card.id),
        ),
    ];

    return response;
  }
}
