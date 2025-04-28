import 'dart:developer';
import 'dart:io' show File;

import 'package:csv/csv.dart';
import 'package:flutter/material.dart' show Locale;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import 'package:master_key/dependency_injection.dart';
import 'package:master_key/src/src.dart';
import 'dart:io' show Directory;

class CSVExporter {
  final AppDatabase appDatabase;
  final SharedPreferences prefs;
  final AppLocalizations lang;
  final String langCode;

  CSVExporter()
    : appDatabase = sl<AppDatabase>(),
      prefs = sl<SharedPreferences>(),
      langCode =
          AppLocals.fromIndex(
            sl<SharedPreferences>().getInt(SharedPreferencesKeys.locale),
          ).code,
      lang = lookupAppLocalizations(
        Locale(
          AppLocals.fromIndex(
            sl<SharedPreferences>().getInt(SharedPreferencesKeys.locale),
          ).code,
        ),
      );

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
      log('Error exporting cards: $e');
      throw CustomFailure('Error exporting cards: $e');
    }

    return csvFiles;
  }

  Future<List<File>> _exportPasswords(String separator) async {
    final rawData = await appDatabase.passwordDao.getPasswords(
      force: true,
      GetAllPasswordsParams(order: OrderType.byCreationTime, reverse: false),
    );

    if (rawData.isEmpty) return [];

    List<String> headers = [
      lang.title,
      ...FieldType.getFields.map((e) => e.name),
      lang.createdAt,
      lang.updatedAt,
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
          row[index] =
              fieldType.isDate
                  ? DateTime.tryParse(
                    field.value,
                  )?.datetimeYMD(lang, detect: true).toString()
                  : field.value;
        }
        row[headers.indexOf(lang.createdAt)] =
            password.createdAt.datetimeToCSV(lang).toString();
        row[headers.indexOf(lang.updatedAt)] =
            password.updatedAt.datetimeToCSV(lang).toString();
        return row;
      }).toList(),
    );

    // log(
    //   ListToCsvConverter(fieldDelimiter: separator).convert([headers, ...data]),
    //   name: "Data",
    // );

    headers = List.from(headers)..replaceRange(
      1,
      headers.length - 2,
      FieldType.getFields.map((e) => e.getHintText(lang, backup: true)),
    );
    log(headers.toString(), name: "Headers");
    List<List<String>> rows = List.generate(
      data.length,
      (index) =>
          List.generate(headers.length, (i) => data[index][i].toString()),
    );

    // Remove columns where all values are null or empty
    for (int col = headers.length - 1; col >= 0; col--) {
      final columnName = headers[col];
      bool hasValues = rows.every((row) => row[col].isEmpty);
      log('$columnName: $hasValues', name: "Column Check");
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

    log(csv, name: "Already Data");

    return [await createTempFile('passwords.csv', csv)];
  }

  Future<List<File>> _exportWallets(String separator) async {
    final data = await appDatabase.walletDao.getAllWallets(
      force: true,
      GetAllWalletsParams(order: OrderType.byCreationTime, reverse: false),
    );

    if (data.isEmpty) return [];

    final headers = [
      lang.title,
      lang.phraseKey,
      lang.createdAt,
      lang.updatedAt,
    ];
    final rows =
        data
            .map(
              (e) => [
                e.title,
                e.seedPhrase,
                e.createdAt.datetimeToCSV(lang),
                e.updatedAt.datetimeToCSV(lang),
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
      lang.title,
      lang.holderName,
      lang.number,
      lang.expireDate,
      lang.cvv,
      lang.createdAt,
      lang.updatedAt,
    ];
    log('Card: ${data.toString()}');
    final List<List<String>> rows =
        data.map((e) {
          return <String>[
            "'${e.title}'",
            "'${e.holderName}'",
            "'${e.number}'",
            e.expireDate.toString(),
            e.cvv.toString(),
            e.createdAt.datetimeToCSV(lang),
            e.updatedAt.datetimeToCSV(lang),
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
