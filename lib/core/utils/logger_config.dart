import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

/// Módulo de Injectable para registrar el Logger en GetIt
@module
abstract class LoggerModule {
  /// Proporciona una instancia singleton del Logger
  /// Configurado con PrettyPrinter para una salida legible
  @lazySingleton
  Logger get logger => Logger(
    printer: PrettyPrinter(),
    level: Level.debug,
  );
}
