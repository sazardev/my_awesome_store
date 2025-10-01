import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_awesome_store/core/database/app_database.dart' as db;
import 'package:my_awesome_store/features/products/domain/entities/product.dart';

part 'product_model.freezed.dart';

/// Modelo de Producto (Data Layer)
/// Extiende la entidad del dominio y agrega serialización
@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    required double price,
    required int stock,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? description,
    String? barcode,
    String? category,
    String? rackLocation,
  }) = _ProductModel;

  /// Crea un ProductModel desde una entidad del dominio
  factory ProductModel.fromEntity(Product entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      price: entity.price,
      stock: entity.stock,
      description: entity.description,
      barcode: entity.barcode,
      category: entity.categoryId,
      rackLocation: entity.rackLocation,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Crea un ProductModel desde un registro de Drift
  factory ProductModel.fromDrift(db.Product data) {
    return ProductModel(
      id: data.id,
      name: data.name,
      price: data.price,
      stock: data.stock,
      description: data.description,
      barcode: data.barcode,
      category: data.category,
      rackLocation: data.rackLocation,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt ?? DateTime.now(),
    );
  }
  const ProductModel._();

  /// Convierte a entidad del dominio
  Product toEntity() {
    return Product(
      id: id,
      name: name,
      price: price,
      stock: stock,
      description: description,
      barcode: barcode,
      categoryId: category,
      rackLocation: rackLocation,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
