import 'package:my_awesome_store/core/constants/app_constants.dart';

/// Validadores para formularios
/// Retorna String con mensaje de error, o null si es válido
class Validators {
  Validators._();

  /// Valida que el campo no esté vacío
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'Este campo'} es requerido';
    }
    return null;
  }

  /// Valida email
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es requerido';
    }

    final emailRegex = RegExp(AppConstants.emailPattern);
    if (!emailRegex.hasMatch(value)) {
      return 'Ingresa un email válido';
    }

    return null;
  }

  /// Valida teléfono (10 dígitos)
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'El teléfono es requerido';
    }

    final phoneRegex = RegExp(AppConstants.phonePattern);
    if (!phoneRegex.hasMatch(value)) {
      return 'Ingresa un teléfono válido (10 dígitos)';
    }

    return null;
  }

  /// Valida longitud mínima
  static String? minLength(
    String? value,
    int min, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Este campo'} es requerido';
    }

    if (value.length < min) {
      return '${fieldName ?? 'Este campo'} debe tener al menos $min caracteres';
    }

    return null;
  }

  /// Valida longitud máxima
  static String? maxLength(
    String? value,
    int max, {
    String? fieldName,
  }) {
    if (value != null && value.length > max) {
      return '${fieldName ?? 'Este campo'} no puede tener más de $max caracteres';
    }

    return null;
  }

  /// Valida rango de longitud
  static String? lengthRange(
    String? value,
    int min,
    int max, {
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Este campo'} es requerido';
    }

    if (value.length < min || value.length > max) {
      return '${fieldName ?? 'Este campo'} debe tener entre $min y $max caracteres';
    }

    return null;
  }

  /// Valida que sea un número
  static String? number(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Este campo'} es requerido';
    }

    if (double.tryParse(value) == null) {
      return '${fieldName ?? 'Este campo'} debe ser un número válido';
    }

    return null;
  }

  /// Valida que sea un número positivo
  static String? positiveNumber(String? value, {String? fieldName}) {
    final numberError = number(value, fieldName: fieldName);
    if (numberError != null) return numberError;

    final num = double.parse(value!);
    if (num <= 0) {
      return '${fieldName ?? 'Este campo'} debe ser un número positivo';
    }

    return null;
  }

  /// Valida precio (mayor a 0, máximo 2 decimales)
  static String? price(String? value) {
    if (value == null || value.isEmpty) {
      return 'El precio es requerido';
    }

    final priceValue = double.tryParse(value);
    if (priceValue == null) {
      return 'Ingresa un precio válido';
    }

    if (priceValue < AppConstants.minPrice) {
      return 'El precio debe ser mayor a ${AppConstants.minPrice}';
    }

    // Validar máximo 2 decimales
    final decimalRegex = RegExp(AppConstants.positiveDecimalPattern);
    if (!decimalRegex.hasMatch(value)) {
      return 'El precio puede tener máximo 2 decimales';
    }

    return null;
  }

  /// Valida stock (entero no negativo)
  static String? stock(String? value) {
    if (value == null || value.isEmpty) {
      return 'El stock es requerido';
    }

    final stockValue = int.tryParse(value);
    if (stockValue == null) {
      return 'Ingresa un stock válido';
    }

    if (stockValue < 0) {
      return 'El stock no puede ser negativo';
    }

    return null;
  }

  /// Valida nombre de producto
  static String? productName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre del producto es requerido';
    }

    if (value.length < AppConstants.minProductNameLength) {
      return 'El nombre debe tener al menos ${AppConstants.minProductNameLength} caracteres';
    }

    if (value.length > AppConstants.maxProductNameLength) {
      return 'El nombre no puede tener más de ${AppConstants.maxProductNameLength} caracteres';
    }

    return null;
  }

  /// Valida que dos campos sean iguales (para confirmar contraseñas, etc.)
  static String? match(
    String? value,
    String? otherValue, {
    String? fieldName,
  }) {
    if (value != otherValue) {
      return '${fieldName ?? 'Los campos'} no coinciden';
    }
    return null;
  }

  /// Combina múltiples validadores
  /// Retorna el primer error encontrado, o null si todos pasan
  static String? combine(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) return error;
    }
    return null;
  }

  /// Validador personalizado con condición
  static String? Function(String?) custom(
    bool Function(String?) condition,
    String errorMessage,
  ) {
    return (value) {
      if (!condition(value)) {
        return errorMessage;
      }
      return null;
    };
  }
}

/// Ejemplo de uso:
/// 
/// ```dart
/// TextFormField(
///   validator: Validators.combine(
///     [
///       Validators.required,
///       (value) => Validators.minLength(value, 3, fieldName: 'Nombre'),
///       (value) => Validators.maxLength(value, 50, fieldName: 'Nombre'),
///     ],
///   ),
/// )
/// 
/// TextFormField(
///   validator: Validators.productName,
/// )
/// 
/// TextFormField(
///   validator: Validators.price,
/// )
/// ```
