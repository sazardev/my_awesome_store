import 'dart:math' show pow;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Extensiones útiles para String
extension StringExtensions on String {
  /// Capitaliza la primera letra
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitaliza la primera letra de cada palabra
  String capitalizeEachWord() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Verifica si el string es un email válido
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Verifica si el string es un número válido
  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  /// Remueve espacios extras
  String removeExtraSpaces() {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Trunca el string y agrega "..." si es muy largo
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// Convierte a double de forma segura
  double toDoubleOrZero() {
    return double.tryParse(this) ?? 0.0;
  }

  /// Convierte a int de forma segura
  int toIntOrZero() {
    return int.tryParse(this) ?? 0;
  }
}

/// Extensiones útiles para DateTime
extension DateTimeExtensions on DateTime {
  /// Formatea como fecha (dd/MM/yyyy)
  String toFormattedDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  /// Formatea como fecha y hora (dd/MM/yyyy HH:mm)
  String toFormattedDateTime() {
    return DateFormat('dd/MM/yyyy HH:mm').format(this);
  }

  /// Formatea como hora (HH:mm)
  String toFormattedTime() {
    return DateFormat('HH:mm').format(this);
  }

  /// Verifica si es hoy
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Verifica si es ayer
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Verifica si es esta semana
  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return isAfter(startOfWeek) && isBefore(endOfWeek);
  }

  /// Obtiene el inicio del día (00:00:00)
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  /// Obtiene el fin del día (23:59:59)
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  /// Texto amigable relativo (hace X minutos, ayer, etc.)
  String toRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'Hace ${difference.inSeconds} segundos';
    } else if (difference.inMinutes < 60) {
      return 'Hace ${difference.inMinutes} minutos';
    } else if (difference.inHours < 24) {
      return 'Hace ${difference.inHours} horas';
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else if (difference.inDays < 30) {
      return 'Hace ${(difference.inDays / 7).floor()} semanas';
    } else if (difference.inDays < 365) {
      return 'Hace ${(difference.inDays / 30).floor()} meses';
    } else {
      return 'Hace ${(difference.inDays / 365).floor()} años';
    }
  }
}

/// Extensiones útiles para double (precios, cantidades)
extension DoubleExtensions on double {
  /// Formatea como precio con símbolo de moneda
  String toFormattedPrice({String symbol = r'$'}) {
    final formatter = NumberFormat('#,##0.00');
    return '$symbol${formatter.format(this)}';
  }

  /// Formatea como porcentaje
  String toFormattedPercentage({int decimals = 1}) {
    return '${toStringAsFixed(decimals)}%';
  }

  /// Redondea a N decimales
  double roundToDecimals(int decimals) {
    final mod = pow(10.0, decimals) as double;
    return (this * mod).round().toDouble() / mod;
  }
}

/// Extensiones útiles para int
extension IntExtensions on int {
  /// Formatea con separadores de miles
  String toFormattedNumber() {
    final formatter = NumberFormat('#,##0');
    return formatter.format(this);
  }

  /// Verifica si es par
  bool get isEven => this % 2 == 0;

  /// Verifica si es impar
  bool get isOdd => this % 2 != 0;

  /// Convierte a duración en días
  Duration get days => Duration(days: this);

  /// Convierte a duración en horas
  Duration get hours => Duration(hours: this);

  /// Convierte a duración en minutos
  Duration get minutes => Duration(minutes: this);

  /// Convierte a duración en segundos
  Duration get seconds => Duration(seconds: this);
}

/// Extensiones útiles para List
extension ListExtensions<T> on List<T> {
  /// Verifica si la lista no está vacía
  bool get isNotEmpty => !isEmpty;

  /// Obtiene elemento de forma segura (sin crash si índice inválido)
  T? getOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Divide la lista en chunks/páginas
  List<List<T>> chunked(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }
}

/// Extensiones útiles para BuildContext
extension BuildContextExtensions on BuildContext {
  /// Acceso rápido al ThemeData
  ThemeData get theme => Theme.of(this);

  /// Acceso rápido al TextTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Acceso rápido al ColorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Acceso rápido al MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Ancho de la pantalla
  double get width => mediaQuery.size.width;

  /// Alto de la pantalla
  double get height => mediaQuery.size.height;

  /// Verifica si es un dispositivo móvil pequeño
  bool get isSmallScreen => width < 600;

  /// Verifica si es una tablet
  bool get isTablet => width >= 600 && width < 900;

  /// Verifica si es una pantalla grande (desktop)
  bool get isDesktop => width >= 900;

  /// Muestra un SnackBar fácilmente
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }

  /// Muestra un SnackBar de error
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  /// Muestra un SnackBar de éxito
  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Cierra el teclado
  void dismissKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
