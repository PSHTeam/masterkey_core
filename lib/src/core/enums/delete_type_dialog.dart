import 'package:flutter/material.dart';
import 'package:master_key/src/core/core.dart';

enum DeleteTypeDialog {
  category,
  password,
  wallet,
  card,
  data;

  bool get isData => this == data;

  String getTitle(BuildContext context) => switch (this) {
    DeleteTypeDialog.category => context.lang.deleteCollection,
    DeleteTypeDialog.password => context.lang.deletePassword,
    DeleteTypeDialog.wallet => context.lang.deleteWallet,
    DeleteTypeDialog.card => context.lang.deleteCard,
    DeleteTypeDialog.data => context.lang.deleteData,
  };

  String getSubtitle(BuildContext context) => switch (this) {
    DeleteTypeDialog.category => context.lang.deleteCollectionSubTitle,
    DeleteTypeDialog.password => context.lang.deletePasswordSubTitle,
    DeleteTypeDialog.wallet => context.lang.deleteWalletSubTitle,
    DeleteTypeDialog.card => context.lang.deleteCardSubTitle,
    DeleteTypeDialog.data => context.lang.deleteDataSubTitle,
  };
}
