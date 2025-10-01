import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

/// Configuración de variables de entorno
/// Carga variables desde archivos .env
@module
abstract class EnvConfigModule {
  /// Base URL de la API
  @lazySingleton
  @Named('apiBaseUrl')
  String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api';

  /// API Key
  @lazySingleton
  @Named('apiKey')
  String get apiKey => dotenv.env['API_KEY'] ?? '';

  /// Timeout de la API en milisegundos
  @lazySingleton
  @Named('apiTimeout')
  int get apiTimeout =>
      int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30000') ?? 30000;

  /// Nombre de la base de datos
  @lazySingleton
  @Named('dbName')
  String get dbName => dotenv.env['DB_NAME'] ?? 'my_awesome_store.db';

  /// Versión de la base de datos
  @lazySingleton
  @Named('dbVersion')
  int get dbVersion => int.tryParse(dotenv.env['DB_VERSION'] ?? '1') ?? 1;

  /// Indica si el modo debug está activo
  @lazySingleton
  @Named('debugMode')
  bool get debugMode => dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';

  /// Indica si Analytics está habilitado
  @lazySingleton
  @Named('enableAnalytics')
  bool get enableAnalytics =>
      dotenv.env['ENABLE_ANALYTICS']?.toLowerCase() == 'true';

  /// Indica si Crash Reporting está habilitado
  @lazySingleton
  @Named('enableCrashReporting')
  bool get enableCrashReporting =>
      dotenv.env['ENABLE_CRASH_REPORTING']?.toLowerCase() == 'true';

  /// Nombre de la aplicación
  @lazySingleton
  @Named('appName')
  String get appName => dotenv.env['APP_NAME'] ?? 'My Awesome Store';

  /// Versión de la aplicación
  @lazySingleton
  @Named('appVersion')
  String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';

  /// Entorno actual (development, staging, production)
  @lazySingleton
  @Named('environment')
  String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';
}

/// Clase helper para acceder a las variables de entorno
/// sin necesidad de inyección de dependencias
class EnvConfig {
  EnvConfig._();

  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static int get apiTimeout =>
      int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30000') ?? 30000;
  static String get dbName => dotenv.env['DB_NAME'] ?? 'my_awesome_store.db';
  static int get dbVersion =>
      int.tryParse(dotenv.env['DB_VERSION'] ?? '1') ?? 1;
  static bool get debugMode =>
      dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';
  static bool get enableAnalytics =>
      dotenv.env['ENABLE_ANALYTICS']?.toLowerCase() == 'true';
  static bool get enableCrashReporting =>
      dotenv.env['ENABLE_CRASH_REPORTING']?.toLowerCase() == 'true';
  static String get appName => dotenv.env['APP_NAME'] ?? 'My Awesome Store';
  static String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';
  static String get environment => dotenv.env['ENVIRONMENT'] ?? 'development';

  /// Indica si estamos en modo desarrollo
  static bool get isDevelopment => environment == 'development';

  /// Indica si estamos en modo producción
  static bool get isProduction => environment == 'production';

  /// Indica si estamos en modo staging
  static bool get isStaging => environment == 'staging';
}
