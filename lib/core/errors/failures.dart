import 'package:equatable/equatable.dart';

/// Representa los diferentes tipos de fallos que pueden ocurrir en la aplicación
abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];

  /// Mensaje de error amigable para el usuario
  String get userMessage {
    if (message.contains('Internet') || message.contains('connection')) {
      return 'No hay conexión a internet';
    } else if (message.contains('timeout')) {
      return 'La operación tardó demasiado tiempo';
    }
    return 'Ocurrió un error. Por favor, inténtalo de nuevo.';
  }
}

/// Fallo del servidor o API
class ServerFailure extends Failure {
  const ServerFailure(super.message, {this.statusCode});

  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];

  @override
  String get userMessage {
    if (statusCode == 404) {
      return 'Recurso no encontrado';
    } else if (statusCode == 500) {
      return 'Error del servidor. Intenta más tarde.';
    } else if (statusCode == 401 || statusCode == 403) {
      return 'No tienes permiso para realizar esta acción';
    }
    return super.userMessage;
  }
}

/// Fallo de la base de datos local
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, {this.details});

  final String? details;

  @override
  List<Object?> get props => [message, details];

  @override
  String get userMessage =>
      'Error al acceder a los datos locales. Intenta reiniciar la aplicación.';
}

/// Fallo de conexión de red
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);

  @override
  String get userMessage => 'No hay conexión a internet. Verifica tu red.';
}

/// Fallo de caché
class CacheFailure extends Failure {
  const CacheFailure(super.message);

  @override
  String get userMessage => 'Error al cargar los datos guardados.';
}

/// Fallo inesperado/desconocido
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, {this.error});

  final Object? error;

  @override
  List<Object?> get props => [message, error];

  @override
  String get userMessage =>
      'Ocurrió un error inesperado. Por favor, contacta soporte.';
}

/// Fallo de validación
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {this.fieldErrors});

  final Map<String, String>? fieldErrors;

  @override
  List<Object?> get props => [message, fieldErrors];

  @override
  String get userMessage {
    if (fieldErrors != null && fieldErrors!.isNotEmpty) {
      return fieldErrors!.values.first;
    }
    return message;
  }
}
