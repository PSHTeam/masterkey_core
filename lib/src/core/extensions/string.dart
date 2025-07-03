import 'dart:io' show File;

extension StringExtension on String {
  bool get isSvg => endsWith('.svg');
  bool get isEmoji => !(isSvg || isImage);
  bool get isIcoText => endsWith('.ti');

  // for image extensions
  bool get isPng => endsWith('.png');
  bool get isJpg => endsWith('.jpg');
  bool get isJpeg => endsWith('.jpeg');
  bool get isWebp => endsWith('.webp');
  bool get isIco => endsWith('.ico');
  bool get isImage => isPng || isJpg || isJpeg || isWebp || isIco;

  File get toFile => File(this);
}
