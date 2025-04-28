import 'dart:developer' show log;

import 'package:drift/drift.dart';
import 'package:master_key/src/src.dart';
import 'package:master_key/dependency_injection.dart';

part 'card_dao.g.dart';

@DriftAccessor(tables: [CardTable, CardFieldTable])
class CardDao extends DatabaseAccessor<AppDatabase> with _$CardDaoMixin {
  CardDao(super.db);

  Future<CardTableData> insertCard(CardModel card) async {
    final encryptor = sl<DatabaseEncryptorService>();
    try {
      final newCard = await into(cardTable).insertReturning(
        card.toTableCompanion().copyWith(
          title: Value(encryptor.encryptText(card.title)),
          holderName: Value(encryptor.encryptText(card.holderName)),
          number: Value(encryptor.encryptText(card.number.toString())),
          cvv: Value(encryptor.encryptText(card.cvv.toString())),
          pin: Value(
            encryptor.encryptTextOrNull(card.pin.toString(), isPin: true),
          ),
        ),
      );
      log('New card: $newCard');

      if (card.fields.isEmpty) {
        return newCard.copyWith(
          title: encryptor.decryptText(newCard.title),
          holderName: encryptor.decryptText(newCard.holderName),
          cvv: encryptor.decryptText(newCard.cvv),
          number: encryptor.decryptText(newCard.number),
          pin: Value(encryptor.decryptTextOrNull(newCard.pin)),
        );
      }

      await batch((batch) async {
        for (final field in card.fields) {
          await into(cardFieldTable).insert(
            CardFieldTableCompanion(
              cardId: Value(newCard.id),
              type: Value(field.type),
              value: Value(encryptor.encryptText(field.value)),
              createdAt: Value(field.createdAt),
            ),
          );
        }
      });

      return newCard;
    } catch (e) {
      log('Error inserting card: $e');
      throw CustomFailure(e.toString());
    }
  }

  Future<CardTableData?> getCard(int id) async {
    final encryptor = sl<DatabaseEncryptorService>();
    final card =
        await (select(cardTable)
          ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    if (card != null) {
      return card.copyWith(
        title: encryptor.decryptText(card.title),
        holderName: encryptor.decryptText(card.holderName),
        cvv: encryptor.decryptText(card.cvv),
        number: encryptor.decryptText(card.number),
        pin: Value(encryptor.decryptTextOrNull(card.pin)),
      );
    }
    return null;
  }

  Future<int> updateCard({required CardModel card, int? pin}) async {
    final encryptor = sl<DatabaseEncryptorService>();
    return await (update(cardTable)
      ..where((tbl) => tbl.id.equals(card.id!))).write(
      CardTableCompanion(
        title: Value(encryptor.encryptText(card.title)),
        number: Value(encryptor.encryptText(card.number.toString())),
        holderName: Value(encryptor.encryptText(card.holderName)),
        expireDate: Value(card.expireDate),
        cvv: Value(encryptor.encryptText(card.cvv.toString())),
        styleIndex: Value(card.styleIndex),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> toggleArchiveCardStatus({
    required int id,
    required bool status,
  }) async {
    return await (update(cardTable)..where((tbl) => tbl.id.equals(id))).write(
      CardTableCompanion(
        hasArchived: Value(status),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> deleteCard(int id) async {
    return await (delete(cardTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<CardTableData>> getCards(
    GetCardsParams params, {
    bool force = false,
  }) async {
    final encryptor = sl<DatabaseEncryptorService>();
    final cards = select(cardTable);
    if (force) {
      return (await cards.get()).map((card) {
        log(card.toString());
        return card.copyWith(
          title: encryptor.decryptText(card.title),
          holderName: encryptor.decryptText(card.holderName),
          cvv: encryptor.decryptText(card.cvv),
          number: encryptor.decryptText(card.number),
          pin: Value(encryptor.decryptTextOrNull(card.pin)),
        );
      }).toList();
    }

    final mode = params.reverse ? OrderingMode.asc : OrderingMode.desc;

    cards.orderBy([
      switch (params.order) {
        OrderType.byName =>
          (c) => OrderingTerm(
            expression: c.title,
            mode: params.reverse ? OrderingMode.desc : OrderingMode.asc,
          ),
        OrderType.byCreationTime =>
          (c) => OrderingTerm(expression: c.createdAt, mode: mode),
        OrderType.byLastModified =>
          (c) => OrderingTerm(expression: c.updatedAt, mode: mode),
      },
    ]);

    cards.where((tbl) => tbl.hasArchived.equals(params.hasArchived));
    cards.limit(params.limit, offset: params.offset);
    log(
      'limit: ${params.limit}, offset: ${params.offset}, archived: ${params.hasArchived}',
    );
    final result = await cards.get();
    return result
        .map(
          (card) => card.copyWith(
            title: encryptor.decryptText(card.title),
            holderName: encryptor.decryptText(card.holderName),
            cvv: encryptor.decryptText(card.cvv),
            number: encryptor.decryptText(card.number),
            pin: Value(encryptor.decryptTextOrNull(card.pin)),
          ),
        )
        .toList();
  }

  Future<int> updateCardField({
    required int id,
    int? cardId,
    String? type,
    String? value,
    String? hintText,
  }) async {
    final encryptionDB = sl<DatabaseEncryptorService>();
    return (update(cardFieldTable)..where((tbl) => tbl.id.equals(id))).write(
      CardFieldTableCompanion(
        type: type != null ? Value(int.parse(type)) : const Value.absent(),
        value:
            value != null
                ? Value(encryptionDB.encryptText(value))
                : const Value.absent(),
        hintText:
            hintText != null
                ? Value(encryptionDB.encryptText(hintText))
                : const Value.absent(),
        cardId: cardId != null ? Value(cardId) : const Value.absent(),
      ),
    );
  }

  Future<int> deleteCardField(int id) async {
    return (delete(cardFieldTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<CardFieldTableData>> getCardFields(int cardId) async {
    final encryptionDB = sl<DatabaseEncryptorService>();
    final cardFields =
        await (select(cardFieldTable)
          ..where((tbl) => tbl.cardId.equals(cardId))).get();
    return cardFields
        .map(
          (cardField) => cardField.copyWith(
            value: encryptionDB.decryptText(cardField.value),
            hintText: Value(encryptionDB.decryptTextOrNull(cardField.hintText)),
          ),
        )
        .toList();
  }

  Future<List<CardTableData>> searchCards(
    String query, {
    int limit = 30,
    int offset = 0,
  }) async {
    final encryptionDB = sl<DatabaseEncryptorService>();
    final cards =
        await (select(cardTable)
              ..where(
                (tbl) => tbl.title.like('%${encryptionDB.encryptText(query)}%'),
              )
              ..limit(limit, offset: offset))
            .get();
    return cards
        .map(
          (card) => card.copyWith(
            title: encryptionDB.decryptText(card.title),
            holderName: encryptionDB.decryptText(card.holderName),
            cvv: encryptionDB.decryptText(card.cvv),
            number: encryptionDB.decryptText(card.number),
            pin: Value(encryptionDB.decryptText(card.pin!)),
          ),
        )
        .toList();
  }
}
