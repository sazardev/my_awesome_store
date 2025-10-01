import 'package:equatable/equatable.dart';
import 'package:my_awesome_store/core/database/app_database.dart' as db;
import 'package:my_awesome_store/features/products/domain/entities/product.dart';

/// Modelo de Producto (Data Layer)
/// Extiende la entidad del dominio y agrega serialización
class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.barcode,
    this.category,
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
  final String? category;
  final String? rackLocation;

  /// Crea un ProductModel desde una entidad del dominio
  factory ProductModel.fromEntity(Product entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      price: entity.price,
      stock: entity.stock,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      description: entity.description,
      barcode: entity.barcode,
      category: entity.categoryId,
      rackLocation: entity.rackLocation,
    );
  }

  /// Crea un ProductModel desde un registro de Drift
  factory ProductModel.fromDrift(db.Product data) {
    return ProductModel(
      id: data.id,
      name: data.name,
      price: data.price,
      stock: data.stock,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt ?? DateTime.now(),
      description: data.description,
      barcode: data.barcode,
      category: data.category,
      rackLocation: data.rackLocation,
    );
  }

  /// Convierte a entidad del dominio
  Product toEntity() {
    return Product(
      id: id,
      name: name,
      price: price,
      stock: stock,
      createdAt: createdAt,
      updatedAt: updatedAt,
      description: description,
      barcode: barcode,
      categoryId: category,
      rackLocation: rackLocation,
    );
  }

  /// Crea una copia del modelo con los campos especificados modificados
  ProductModel copyWith({
    String? id,
    String? name,
    double? price,
    int? stock,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    String? barcode,
    String? category,
    String? rackLocation,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      barcode: barcode ?? this.barcode,
      category: category ?? this.category,
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
    category,
    rackLocation,
  ];

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, price: $price, stock: $stock, '
        'createdAt: $createdAt, updatedAt: $updatedAt, description: $description, '
        'barcode: $barcode, category: $category, rackLocation: $rackLocation)';
  }
}
