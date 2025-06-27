import 'package:flutter/material.dart';
import 'package:master_key/src/core/core.dart';


enum OrderType {
  byName,
  byCreationTime,
  byLastModified;

  String getName(BuildContext context) => switch (this) {
    OrderType.byName => context.lang.sortByName,
    OrderType.byCreationTime => context.lang.sortByCreation,
    OrderType.byLastModified => context.lang.sortByLastModified,
  };

  factory OrderType.fromIndex(int? index) {
    return OrderType.values.firstWhere(
      (element) => element.index == index,
      orElse: () => OrderType.byLastModified,
    );
  }
}
