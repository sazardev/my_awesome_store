import 'package:equatable/equatable.dart';

/// Entidad de Producto
/// Representa un producto en el dominio de la aplicación
class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.barcode,
    this.categoryId,
    this.rackLocation,
  });

  final String id;
  final String name;
  final double price;
  final int stock;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? description;
  final String? barcode;
  final String? categoryId;
  final String? rackLocation;

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

  /// Crea una copia del producto con los campos especificados modificados
  Product copyWith({
    String? id,
    String? name,
    double? price,
    int? stock,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    String? barcode,
    String? categoryId,
    String? rackLocation,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      barcode: barcode ?? this.barcode,
      categoryId: categoryId ?? this.categoryId,
      rackLocation: rackLocation ?? this.rackLocation,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    stock,
    createdAt,
    updatedAt,
    description,
    barcode,
    categoryId,
    rackLocation,
  ];

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, stock: $stock, '
        'createdAt: $createdAt, updatedAt: $updatedAt, description: $description, '
        'barcode: $barcode, categoryId: $categoryId, rackLocation: $rackLocation)';
  }
}
