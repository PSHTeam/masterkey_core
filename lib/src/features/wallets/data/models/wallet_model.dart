import 'package:drift/drift.dart';
import 'package:masterkey_core/src/src.dart';

class WalletModel extends Wallet {
  const WalletModel({
    required super.id,
    required super.title,
    required super.seedPhrase,
    required super.hasArchived,
    required super.createdAt,
    required super.updatedAt,
  });

  factory WalletModel.fromTableData(WalletTableData tableData) {
    return WalletModel(
      id: tableData.id,
      title: tableData.title,
      seedPhrase: tableData.seedPhrase,
      hasArchived: tableData.hasArchived,
      createdAt: tableData.createdAt,
      updatedAt: tableData.updatedAt,
    );
  }

  WalletTableCompanion toTableCompanion() {
    return WalletTableCompanion(
      id: Value(id),
      title: Value(title),
      seedPhrase: Value(seedPhrase),
      hasArchived: Value(hasArchived),
    );
  }

  Wallet toEntity() {
    return Wallet(
      id: id,
      title: title,
      seedPhrase: seedPhrase,
      hasArchived: hasArchived,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory WalletModel.fromEntity(Wallet entity) {
    return WalletModel(
      id: entity.id,
      title: entity.title,
      seedPhrase: entity.seedPhrase,
      hasArchived: entity.hasArchived,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  WalletModel copyWith({
    int? id,
    String? title,
    String? seedPhrase,
    bool? hasArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WalletModel(
      id: id ?? this.id,
      title: title ?? this.title,
      seedPhrase: seedPhrase ?? this.seedPhrase,
      hasArchived: hasArchived ?? this.hasArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
