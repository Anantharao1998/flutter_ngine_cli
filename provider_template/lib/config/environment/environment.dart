import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:juno_provider_base_project/config/config.dart';

// This class is to get environmental variables from respective .env files
class Environment {
  Environment._();
  static String get fileName => FlavorConfig.isProduction
      ? '.env.production'
      : FlavorConfig.isDevelopment
          ? '.env.development'
          : '.env.uat';
  static String get apiUrl => dotenv.env['API_URL'] ?? 'MY_FALLBACK';
}
