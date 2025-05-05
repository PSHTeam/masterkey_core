import 'dart:io' show File;

import 'package:equatable/equatable.dart';

abstract class IconEntity extends Equatable {
  const IconEntity();
 
  @override
  List<Object?> get props => [];
}

class SvgIcon extends IconEntity {
  final String icon;
  final String name;

  const SvgIcon(this.icon, this.name);

  @override
  List<Object> get props => [icon, name];
}


class EmojiIcon extends IconEntity {
  final String emoji;

  const EmojiIcon(this.emoji);

  @override
  List<Object> get props => [emoji];
}

class CustomIcon extends IconEntity {
  final File file;

  const CustomIcon(this.file);

  @override
  List<Object> get props => [file];
}
