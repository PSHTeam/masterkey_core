import 'package:masterkey_core/src/src.dart';

class BackupModel extends Backup {
  const BackupModel({
    required super.backupSize,
    required super.backupPath,
    required super.lastBackupUpdate,
  });

  Backup toEntity() {
    return Backup(
      backupSize: backupSize,
      backupPath: backupPath,
      lastBackupUpdate: lastBackupUpdate,
    );
  }

  factory BackupModel.fromEntity(Backup entity) {
    return BackupModel(
      backupSize: entity.backupSize,
      backupPath: entity.backupPath,
      lastBackupUpdate: entity.lastBackupUpdate,
    );
  }

  BackupModel copyWith({
    int? backupSize,
    String? backupPath,
    DateTime? lastBackupUpdate,
  }) {
    return BackupModel(
      backupSize: backupSize ?? this.backupSize,
      backupPath: backupPath ?? this.backupPath,
      lastBackupUpdate: lastBackupUpdate ?? this.lastBackupUpdate,
    );
  }
}
