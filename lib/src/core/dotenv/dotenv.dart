import 'env.dart' as release_env;

class Dotenv {
  String get appIv => release_env.Env.appIv;
  String get appKey => release_env.Env.appKey;
}

final Dotenv dotenvs = Dotenv();
