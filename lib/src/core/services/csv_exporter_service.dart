import 'dart:io' show File;

import 'package:csv/csv.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import 'package:masterkey_core/dependency_injection.dart';
import 'package:masterkey_core/src/src.dart';
import 'dart:io' show Directory;

class CSVExporter {
  final AppDatabase appDatabase;
  final SharedPreferences sharedPreferences;

  CSVExporter()
    : appDatabase = sl<AppDatabase>(),
      sharedPreferences = sl<SharedPreferences>();

  Future<List<File>> export(
    String separator, {
    TableType table = TableType.all,
  }) async {
    final csvFiles = <File>[];

    if (table.isAll || table.isPassword) {
      csvFiles.addAll(await _exportPasswords(separator));
    }
    if (table.isAll || table.isWallet) {
      csvFiles.addAll(await _exportWallets(separator));
    }
    try {
      if (table.isAll || table.isCard) {
        csvFiles.addAll(await _exportCards(separator));
      }
    } catch (e) {
      throw CustomFailure('Error exporting cards: $e');
    }

    return csvFiles;
  }

  Future<List<File>> _exportPasswords(String separator) async {
    final rawData = await appDatabase.passwordDao.getPasswords(
      force: true,
      GetAllPasswordsParams(
        order: OrderType.byCreationTime,
        reverse: false,
        passwordsType: HomePasswordsType.unsorted,
      ),
    );

    if (rawData.isEmpty) return [];

    List<String> headers = [
      "Title",
      ...FieldType.getFields.map((e) => e.name),
      "Created at",
      "Updated at",
    ];

    final data = await Future.wait(
      rawData.map((password) async {
        final row = List<dynamic>.filled(headers.length, '');
        row[0] = password.title;
        final fields = await appDatabase.passwordDao.getPasswordFields(
          password.id,
        );
        for (var field in fields) {
          final fieldType = FieldType.getFields[field.type];
          final index = headers.indexOf(fieldType.name);
          row[index] = fieldType.isDate
              ? datetimeYMD(DateTime.parse(field.value))
              : field.value;
        }
        row[headers.indexOf("Created at")] = datetimeToCSV(password.createdAt);
        row[headers.indexOf("Updated at")] = datetimeToCSV(password.updatedAt);
        return row;
      }).toList(),
    );

    headers = List.from(headers)
      ..replaceRange(
        1,
        headers.length - 2,
        FieldType.getFields.map((e) => e.name),
      );
    List<List<String>> rows = List.generate(
      data.length,
      (index) =>
          List.generate(headers.length, (i) => data[index][i].toString()),
    );

    for (int col = headers.length - 1; col >= 0; col--) {
      bool hasValues = rows.every((row) => row[col].isEmpty);
      if (hasValues) {
        headers.removeAt(col);
        for (var row in rows) {
          row.removeAt(col);
        }
      }
    }

    final csv = ListToCsvConverter(
      fieldDelimiter: separator,
    ).convert([headers, ...rows]);

    return [await createTempFile('passwords.csv', csv)];
  }

  Future<List<File>> _exportWallets(String separator) async {
    final data = await appDatabase.walletDao.getAllWallets(
      force: true,
      GetAllWalletsParams(order: OrderType.byCreationTime, reverse: false),
    );

    if (data.isEmpty) return [];

    final headers = ["Title", "Phrase Key", "Created at", "Updated at"];
    final rows = data
        .map(
          (e) => [
            e.title,
            e.seedPhrase,
            datetimeToCSV(e.createdAt),
            datetimeToCSV(e.updatedAt),
          ],
        )
        .toList();

    final csv = ListToCsvConverter(
      fieldDelimiter: separator,
    ).convert([headers, ...rows]);

    return [await createTempFile('wallets.csv', csv)];
  }

  Future<List<File>> _exportCards(String separator) async {
    final data = await appDatabase.cardDao.getCards(
      force: true,
      GetCardsParams(order: OrderType.byCreationTime, reverse: false),
    );

    if (data.isEmpty) return [];

    List<String> headers = [
      "Title",
      "HolderName",
      "Number",
      "Expire date",
      "CVV",
      "Created at",
      "Updated at",
    ];
    final List<List<String>> rows = data.map((e) {
      return <String>[
        "'${e.title}'",
        "'${e.holderName}'",
        "'${e.number}'",
        e.expireDate.toString(),
        e.cvv.toString(),
        datetimeToCSV(e.createdAt),
        datetimeToCSV(e.updatedAt),
      ];
    }).toList();

    final csv = ListToCsvConverter(
      fieldDelimiter: separator,
    ).convert([headers, ...rows]);

    return [await createTempFile('cards.csv', csv)];
  }
}

Future<File> createTempFile(String fileName, String content) async {
  final tempDir = Directory.systemTemp;
  final tempFile = File('${tempDir.path}/$fileName');
  await tempFile.writeAsString(content, flush: true);
  return tempFile;
}

String datetimeToCSV(DateTime dateTime) {
  return DateFormat('MMM d, y h:mm a', 'en').format(dateTime);
}

String datetimeYMD(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd', 'en').format(dateTime);
}
