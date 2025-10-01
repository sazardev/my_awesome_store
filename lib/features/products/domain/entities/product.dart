import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

/// Entidad de Producto
/// Representa un producto en el dominio de la aplicación
@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required double price,
    required int stock,
    String? description,
    String? barcode,
    String? categoryId,
    String? rackLocation,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Product;
  const Product._();

  /// Verifica si el producto tiene stock bajo
  bool get hasLowStock => stock <= 5;

  /// Verifica si el producto está sin stock
  bool get isOutOfStock => stock <= 0;

  /// Obtiene el precio formateado
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  /// Verifica si el producto tiene código de barras
  bool get hasBarcode => barcode != null && barcode!.isNotEmpty;

  /// Verifica si el producto tiene categoría
  bool get hasCategory => categoryId != null && categoryId!.isNotEmpty;
}
