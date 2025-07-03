import 'package:drift/drift.dart';
import 'package:masterkey_core/src/src.dart';
import 'package:masterkey_core/dependency_injection.dart';

part 'card_dao.g.dart';

@DriftAccessor(tables: [CardTable, CardFieldTable])
class CardDao extends DatabaseAccessor<AppDatabase> with _$CardDaoMixin {
  CardDao(super.db);

  Future<CardTableData> insertCard(CardModel card) async {
    final encryptor = sl<DatabaseEncryptorService>();
    try {
      final newCard = await into(cardTable).insertReturning(
        card.toTableCompanion().copyWith(
          title: Value(await encryptor.encrypt(card.title)),
          holderName: Value(await encryptor.encrypt(card.holderName)),
          number: Value(await encryptor.encrypt(card.number.toString())),
          cvv: Value(await encryptor.encrypt(card.cvv.toString())),
          pin: Value(
            await encryptor.encryptOrNull(card.pin.toString(), isPin: true),
          ),
        ),
      );

      if (card.fields.isEmpty) {
        return newCard.copyWith(
          title: await encryptor.decrypt(newCard.title),
          holderName: await encryptor.decrypt(newCard.holderName),
          cvv: await encryptor.decrypt(newCard.cvv),
          number: await encryptor.decrypt(newCard.number),
          pin: Value(await encryptor.decryptOrNull(newCard.pin)),
        );
      }

      await batch((batch) async {
        for (final field in card.fields) {
          await into(cardFieldTable).insert(
            CardFieldTableCompanion(
              cardId: Value(newCard.id),
              type: Value(field.type),
              value: Value(await encryptor.encrypt(field.value)),
              createdAt: Value(field.createdAt),
            ),
          );
        }
      });

      return newCard;
    } catch (e) {
      throw CustomFailure(e.toString());
    }
  }

  Future<CardTableData?> getCard(int id) async {
    final encryptor = sl<DatabaseEncryptorService>();
    final card = await (select(
      cardTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    if (card != null) {
      return card.copyWith(
        title: await encryptor.decrypt(card.title),
        holderName: await encryptor.decrypt(card.holderName),
        cvv: await encryptor.decrypt(card.cvv),
        number: await encryptor.decrypt(card.number),
        pin: Value(await encryptor.decryptOrNull(card.pin)),
      );
    }
    return null;
  }

  Future<int> updateCard({required CardModel card, int? pin}) async {
    final encryptor = sl<DatabaseEncryptorService>();
    return await (update(
      cardTable,
    )..where((tbl) => tbl.id.equals(card.id!))).write(
      CardTableCompanion(
        title: Value(await encryptor.encrypt(card.title)),
        number: Value(await encryptor.encrypt(card.number.toString())),
        holderName: Value(await encryptor.encrypt(card.holderName)),
        expireDate: Value(card.expireDate),
        cvv: Value(await encryptor.encrypt(card.cvv.toString())),
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
      final cardList = await cards.get();
      return Future.wait(
        cardList.map((card) async {
          return card.copyWith(
            title: await encryptor.decrypt(card.title),
            holderName: await encryptor.decrypt(card.holderName),
            cvv: await encryptor.decrypt(card.cvv),
            number: await encryptor.decrypt(card.number),
            pin: Value(await encryptor.decryptOrNull(card.pin)),
          );
        }),
      );
    }

    final mode = params.reverse ? OrderingMode.asc : OrderingMode.desc;

    cards.orderBy([
      switch (params.order) {
        OrderType.byName => (c) => OrderingTerm(
          expression: c.title,
          mode: params.reverse ? OrderingMode.desc : OrderingMode.asc,
        ),
        OrderType.byCreationTime => (c) => OrderingTerm(
          expression: c.createdAt,
          mode: mode,
        ),
        OrderType.byLastModified => (c) => OrderingTerm(
          expression: c.updatedAt,
          mode: mode,
        ),
      },
    ]);

    cards.where((tbl) => tbl.hasArchived.equals(params.hasArchived));
    cards.limit(params.limit, offset: params.offset);
    final result = await cards.get();
    return await Future.wait(
      result.map((card) async {
        return card.copyWith(
          title: await encryptor.decrypt(card.title),
          holderName: await encryptor.decrypt(card.holderName),
          cvv: await encryptor.decrypt(card.cvv),
          number: await encryptor.decrypt(card.number),
          pin: Value(await encryptor.decryptOrNull(card.pin)),
        );
      }).toList(),
    );
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
        value: value != null
            ? Value(await encryptionDB.encrypt(value))
            : const Value.absent(),
        hintText: hintText != null
            ? Value(await encryptionDB.encrypt(hintText))
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
    final cardFields = await (select(
      cardFieldTable,
    )..where((tbl) => tbl.cardId.equals(cardId))).get();
    return await Future.wait(
      cardFields.map((cardField) async {
        return cardField.copyWith(
          value: await encryptionDB.decrypt(cardField.value),
          hintText: Value(await encryptionDB.decryptOrNull(cardField.hintText)),
        );
      }),
    );
  }
}
