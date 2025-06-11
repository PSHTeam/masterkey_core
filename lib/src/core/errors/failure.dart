import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class Failure extends Equatable {
  const Failure();

  String getMessage(BuildContext context);

  bool get passable => false;

  @override
  List<Object> get props => [];
}

class AuthFailure extends Failure {
  const AuthFailure();
  @override
  String getMessage(BuildContext context) => "authFailureMsg";
}

class UnknownFailure extends Failure {
  const UnknownFailure();
  @override
  String getMessage(BuildContext context) => "unknownFailureMsg";
}

class WalletFailure extends Failure {
  const WalletFailure();
  @override
  String getMessage(BuildContext context) => "walletFailureMsg";
}

class NotFoundFailure extends Failure {
  const NotFoundFailure();
  @override
  String getMessage(BuildContext context) => "notFoundFailureMsg";
}

class UserNotFoundFailure extends Failure {
  @override
  String getMessage(BuildContext context) => "userNotFoundFailureMsg";
}

class CustomFailure extends Failure {
  final String message;

  const CustomFailure(this.message);

  @override
  String getMessage(BuildContext context) => message;
}

class CancelledBackupFailure extends Failure {
  const CancelledBackupFailure();

  @override
  String getMessage(BuildContext context) => "";
}

class InvalidRestorePassword extends Failure {
  const InvalidRestorePassword();
  @override
  String getMessage(BuildContext context) => "errorRestorePassword";
}

class InvalidRestoreFileFailure extends Failure {
  const InvalidRestoreFileFailure();
  @override
  String getMessage(BuildContext context) => "invalidRestoreFile";
}

class RestoreFileIsEmptyFailure extends Failure {
  const RestoreFileIsEmptyFailure();
  @override
  String getMessage(BuildContext context) => "restoreFileIsEmpty";
}

class RestoreMissingFileFailure extends Failure {
  const RestoreMissingFileFailure(this.fileName);

  final String fileName;
  @override
  String getMessage(BuildContext context) =>
      "restoreMissingFileFailureMsg(filename)";
}

class DecryptRestoreFileFailureMsg extends Failure {
  const DecryptRestoreFileFailureMsg();

  @override
  String getMessage(BuildContext context) => "decryptRestoreFileFailureMsg";
}
