import 'package:drift/drift.dart' as drift;
import 'package:injectable/injectable.dart';
import 'package:my_awesome_store/core/database/app_database.dart';
import 'package:my_awesome_store/core/errors/exceptions.dart';
import 'package:my_awesome_store/features/products/data/models/product_model.dart';

/// DataSource local para productos (usando Drift/SQLite)
@lazySingleton
class ProductLocalDataSource {
  ProductLocalDataSource(this._database);
  final AppDatabase _database;

  /// Obtiene todos los productos
  Future<List<ProductModel>> getProducts() async {
    try {
      final products = await _database.select(_database.products).get();
      return products.map(ProductModel.fromDrift).toList();
    } catch (e) {
      throw DatabaseException('Error al obtener productos: $e');
    }
  }

  /// Obtiene un producto por su ID
  Future<ProductModel> getProductById(String id) async {
    try {
      final product = await (_database.select(
        _database.products,
      )..where((tbl) => tbl.id.equals(id))).getSingle();
      return ProductModel.fromDrift(product);
    } catch (e) {
      throw DatabaseException('Error al obtener producto: $e');
    }
  }

  /// Agrega un nuevo producto
  Future<void> addProduct(ProductModel product) async {
    try {
      await _database
          .into(_database.products)
          .insert(
            ProductsCompanion(
              id: drift.Value(product.id),
              name: drift.Value(product.name),
              price: drift.Value(product.price),
              stock: drift.Value(product.stock),
              description: drift.Value(product.description),
              barcode: drift.Value(product.barcode),
              category: drift.Value(product.category),
              rackLocation: drift.Value(product.rackLocation),
              createdAt: drift.Value(product.createdAt),
              updatedAt: drift.Value(product.updatedAt),
            ),
          );
    } catch (e) {
      throw DatabaseException('Error al agregar producto: $e');
    }
  }

  /// Actualiza un producto existente
  Future<void> updateProduct(ProductModel product) async {
    try {
      await (_database.update(
        _database.products,
      )..where((tbl) => tbl.id.equals(product.id))).write(
        ProductsCompanion(
          name: drift.Value(product.name),
          price: drift.Value(product.price),
          stock: drift.Value(product.stock),
          description: drift.Value(product.description),
          barcode: drift.Value(product.barcode),
          category: drift.Value(product.category),
          rackLocation: drift.Value(product.rackLocation),
          updatedAt: drift.Value(DateTime.now()),
        ),
      );
    } catch (e) {
      throw DatabaseException('Error al actualizar producto: $e');
    }
  }

  /// Elimina un producto
  Future<void> deleteProduct(String id) async {
    try {
      await (_database.delete(
        _database.products,
      )..where((tbl) => tbl.id.equals(id))).go();
    } catch (e) {
      throw DatabaseException('Error al eliminar producto: $e');
    }
  }

  /// Busca productos por nombre
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final products = await (_database.select(
        _database.products,
      )..where((tbl) => tbl.name.like('%$query%'))).get();
      return products.map(ProductModel.fromDrift).toList();
    } catch (e) {
      throw DatabaseException('Error al buscar productos: $e');
    }
  }

  /// Obtiene productos con stock bajo (≤ 5)
  Future<List<ProductModel>> getLowStockProducts() async {
    try {
      final products = await (_database.select(
        _database.products,
      )..where((tbl) => tbl.stock.isSmallerOrEqualValue(5))).get();
      return products.map(ProductModel.fromDrift).toList();
    } catch (e) {
      throw DatabaseException('Error al obtener productos con stock bajo: $e');
    }
  }
}
