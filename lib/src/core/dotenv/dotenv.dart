import 'package:flutter/foundation.dart';

import 'debug/env.dart' as debug_env;
import 'release/env.dart' as release_env;

abstract class Dotenv {
  String get appKey;
  String get appIv;
}

class _DebugDotenv implements Dotenv {
  @override
  String get appIv => debug_env.Env.appIv;

  @override
  String get appKey => debug_env.Env.appKey;
}

class _ReleaseDotenv implements Dotenv {
  @override
  String get appIv => release_env.Env.appIv;

  @override
  String get appKey => release_env.Env.appKey;
}

final Dotenv dotenvs = kDebugMode ? _DebugDotenv() : _ReleaseDotenv();
