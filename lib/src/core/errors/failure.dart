import 'package:equatable/equatable.dart';

enum MasterkeyErrorCode {
  auth,
  unknown,
  notFound,
  cancelledBackup,
  userNotFound,
  invalidRestorePassword,
  invalidRestoreFile,
  restoreFileIsEmpty,
  restoreMissingFile,
  decryptRestoreFile,
  purchase,
  custom,
}

abstract class Failure<T> extends Equatable {
  const Failure();

  MasterkeyErrorCode get code;
  String getMessage({T? context});

  @override
  List<Object> get props => [];
}

class AuthFailure extends Failure<String> {
  const AuthFailure();
  @override
  MasterkeyErrorCode get code => MasterkeyErrorCode.auth;

  @override
  String getMessage({String? context}) {
    return context ?? "Authentication failed. Please try again.";
  }
}

class UnknownFailure extends Failure<String> {
  const UnknownFailure();
  @override
  MasterkeyErrorCode get code => MasterkeyErrorCode.unknown;

  @override
  String getMessage({String? context}) {
    return context ?? "An unknown error occurred. Please try again later.";
  }
}

class NotFoundFailure extends Failure<String> {
  @override
  MasterkeyErrorCode get code => MasterkeyErrorCode.notFound;

  @override
  String getMessage({String? context}) {
    return context ?? "Requested resource not found.";
  }
}

class UserNotFoundFailure extends Failure<String> {
  @override
  MasterkeyErrorCode get code => MasterkeyErrorCode.userNotFound;

  @override
  String getMessage({String? context}) {
    return context ?? "User not found.";
  }
}

class CustomFailure extends Failure<String> {
  final String msg;

  const CustomFailure(this.msg);

  @override
  MasterkeyErrorCode get code => MasterkeyErrorCode.custom;

  @override
  String getMessage({String? context}) => context ?? msg;
}

class CancelledBackupFailure extends Failure<String> {
  const CancelledBackupFailure();

  @override
  MasterkeyErrorCode get code => MasterkeyErrorCode.cancelledBackup;

  @override
  String getMessage({String? context}) {
    return context ?? "Backup operation was cancelled.";
  }
}

class InvalidRestorePassword extends Failure<String> {
  const InvalidRestorePassword();
  @override
  MasterkeyErrorCode get code => MasterkeyErrorCode.invalidRestorePassword;

  @override
  String getMessage({String? context}) {
    return context ?? "Invalid restore password.";
  }
}

class InvalidRestoreFileFailure extends Failure<String> {
  const InvalidRestoreFileFailure();
  @override
  MasterkeyErrorCode get code => MasterkeyErrorCode.invalidRestoreFile;

  @override
  String getMessage({String? context}) {
    return context ?? "Invalid restore file.";
  }
}

class RestoreFileIsEmptyFailure extends Failure<String> {
  const RestoreFileIsEmptyFailure();
  @override
  MasterkeyErrorCode get code => MasterkeyErrorCode.restoreFileIsEmpty;

  @override
  String getMessage({String? context}) {
    return context ?? "Restore file is empty.";
  }
}

class RestoreMissingFileFailure extends Failure<String> {
  final String fileName;
  const RestoreMissingFileFailure(this.fileName);

  @override
  MasterkeyErrorCode get code => MasterkeyErrorCode.restoreMissingFile;

  @override
  String getMessage({String? context}) {
    return context ?? fileName;
  }

}

class DecryptRestoreFileFailureMsg extends Failure<String> {
  const DecryptRestoreFileFailureMsg();

  @override
  MasterkeyErrorCode get code => MasterkeyErrorCode.decryptRestoreFile;

  @override
  String getMessage({String? context}) {
    return context ?? "Failed to decrypt the restore file.";
  }
}
