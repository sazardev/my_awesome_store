/// Excepciones personalizadas para manejo de errores en la capa de datos.
/// Estas excepciones son lanzadas por los DataSources y capturadas por los Repositories.
library;

/// Excepción del servidor/API
class ServerException implements Exception {
  ServerException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ServerException: $message ${statusCode != null ? '(Code: $statusCode)' : ''}';
}

/// Excepción de la base de datos
class DatabaseException implements Exception {
  DatabaseException(this.message, {this.details});

  final String message;
  final String? details;

  @override
  String toString() => 'DatabaseException: $message ${details != null ? '- $details' : ''}';
}

/// Excepción de red/conexión
class NetworkException implements Exception {
  NetworkException(this.message);

  final String message;

  @override
  String toString() => 'NetworkException: $message';
}

/// Excepción de caché
class CacheException implements Exception {
  CacheException(this.message);

  final String message;

  @override
  String toString() => 'CacheException: $message';
}

/// Excepción de validación
class ValidationException implements Exception {
  ValidationException(this.message, {this.fieldErrors});

  final String message;
  final Map<String, String>? fieldErrors;

  @override
  String toString() => 'ValidationException: $message';
}
