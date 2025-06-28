// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(
  path: 'C:\\Projects\\PSHTeam\\MasterKey\\masterkey_desktop\\.env',
  obfuscate: true,
)
abstract class Env {
  @EnviedField(varName: 'APP_KEY', obfuscate: true)
  static final String appKey = _Env.appKey;
  @EnviedField(varName: 'APP_IV', obfuscate: true)
  static final String appIv = _Env.appIv;
}
