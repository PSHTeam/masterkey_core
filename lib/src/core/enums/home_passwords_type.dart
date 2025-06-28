import 'package:flutter/widgets.dart';
import 'package:masterkey_core/src/src.dart';

enum HomePasswordsType {
  unsorted,
  allPasswords;

  bool get isUnsorted => this == unsorted;
  bool get isAllPasswords => this == allPasswords;
}
