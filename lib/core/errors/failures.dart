import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Representa los diferentes tipos de fallos que pueden ocurrir en la aplicación
/// Usando Freezed para pattern matching y union types
@freezed
class Failure with _$Failure {
  const Failure._();

  /// Fallo del servidor o API
  const factory Failure.server({
    required String message,
    int? statusCode,
  }) = ServerFailure;

  /// Fallo de la base de datos local
  const factory Failure.database({
    required String message,
    String? details,
  }) = DatabaseFailure;

  /// Fallo de conexión de red
  const factory Failure.network({
    required String message,
  }) = NetworkFailure;

  /// Fallo de caché
  const factory Failure.cache({
    required String message,
  }) = CacheFailure;

  /// Fallo inesperado/desconocido
  const factory Failure.unexpected({
    required String message,
    Object? error,
  }) = UnexpectedFailure;

  /// Fallo de validación
  const factory Failure.validation({
    required String message,
    Map<String, String>? fieldErrors,
  }) = ValidationFailure;

  /// Mensaje de error técnico (extraído de cada variante)
  @override
  String get message => when(
    server: (msg, code) => msg,
    database: (msg, details) => msg,
    network: (msg) => msg,
    cache: (msg) => msg,
    unexpected: (msg, error) => msg,
    validation: (msg, errors) => msg,
  );

  /// Mensaje de error amigable para el usuario
  String get userMessage => when(
    server: (msg, code) => 'Error del servidor: $msg',
    database: (msg, details) => 'Error de base de datos: $msg',
    network: (msg) => 'Error de conexión: $msg. Verifica tu internet.',
    cache: (msg) => 'Error de caché: $msg',
    unexpected: (msg, error) => 'Error inesperado: $msg',
    validation: (msg, errors) => 'Error de validación: $msg',
  );
}
