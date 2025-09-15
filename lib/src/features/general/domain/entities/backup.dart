import 'package:masterkey_core/src/src.dart' show BaseEntity;

class Backup extends BaseEntity {
  final int backupSize;
  final String backupPath;
  final DateTime lastBackupUpdate;

  const Backup({
    required this.backupSize,
    required this.backupPath,
    required this.lastBackupUpdate,
  });

  @override
  List<Object?> get props => [backupSize, backupPath, lastBackupUpdate];

  factory Backup.empty({required String path}) {
    return Backup(
      backupPath: path,
      backupSize: 0,
      lastBackupUpdate: DateTime.now(),
    );
  }

  factory Backup.fake() {
    return Backup(
      lastBackupUpdate: DateTime.now(),
      backupPath: '',
      backupSize: 12500,
    );
  }
}
