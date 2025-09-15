import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import 'package:masterkey_core/masterkey_core.dart';

abstract class IconEntity extends Equatable {
  const IconEntity();

  @override
  List<Object?> get props => [value];

  String get value;
}

class BrandIcon extends IconEntity {
  final String icon;
  final String name;

  const BrandIcon(this.icon, this.name);

  @override
  List<Object> get props => [icon, name, value];

  @override
  String get value => icon;
}

class TextIcon extends IconEntity {
  final String icon;

  const TextIcon(this.icon);

  @override
  List<Object> get props => [icon, value];

  @override
  String get value => icon;
}

class MaterialIcon extends IconEntity {
  final String name;
  final IconData icon;
  const MaterialIcon(this.name, this.icon);

  @override
  List<Object> get props => [name, icon, value];

  @override
  String get value => name;

  factory MaterialIcon.fromSerialization(String name, IconData icon) {
    return MaterialIcon(
      name,
      IconData(
        icon.codePoint,
        fontFamily: icon.fontFamily,
        fontPackage: icon.fontPackage,
      ),
    );
  }
}

class EmojiIcon extends IconEntity {
  final String emoji;

  const EmojiIcon(this.emoji);

  @override
  List<Object> get props => [emoji, value];

  @override
  String get value => emoji;
}

class CustomIcon extends IconEntity {
  final File file;

  const CustomIcon(this.file);

  @override
  List<Object> get props => [file, value];

  @override
  String get value => file.uri.pathSegments.last;
}

IconEntity getIconEntityFromString(String icon) {
  if (icon.endsWith('.svg')) {
    return BrandIcon(icon, icon.replaceFirst('.svg', '').toUpperCase());
  } else if (icon.endsWith('.png')) {
    return CustomIcon(icon.toFile);
  } else if (icon.endsWith('.ttf')) {
    final List<MaterialIcon> icons = sl<List<MaterialIcon>>();
    return icons.firstWhere((e) => e.name == icon);
  } else if (icon.endsWith('.ti')) {
    return TextIcon(icon);
  } else {
    return EmojiIcon(icon);
  }
}

class IconCacheService extends Equatable {
  final File? original;
  final File? edited;
  const IconCacheService({this.original, this.edited});

  bool get hasOriginal => original != null;
  bool get hasEdited => edited != null;
  bool get hasEmpty => !hasEdited && !hasOriginal;

  IconCacheService setValue({File? original, File? edited}) {
    return IconCacheService(
      original: original ?? this.original,
      edited: edited ?? this.edited,
    );
  }

  IconCacheService copyWith([IconCacheService? other]) {
    return IconCacheService(
      original: other?.original ?? original,
      edited: other?.edited ?? edited,
    );
  }

  @override
  List<Object?> get props => [original, edited];
}
