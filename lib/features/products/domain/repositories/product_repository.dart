import 'package:fpdart/fpdart.dart';
import 'package:my_awesome_store/core/errors/failures.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';

/// Repositorio de Productos (Interface - Capa de Dominio)
/// Define los contratos que debe implementar el repositorio
abstract class ProductRepository {
  /// Obtiene todos los productos
  Future<Either<Failure, List<Product>>> getProducts();

  /// Obtiene un producto por su ID
  Future<Either<Failure, Product>> getProductById(String id);

  /// Agrega un nuevo producto
  Future<Either<Failure, Unit>> addProduct(Product product);

  /// Actualiza un producto existente
  Future<Either<Failure, Unit>> updateProduct(Product product);

  /// Elimina un producto
  Future<Either<Failure, Unit>> deleteProduct(String id);

  /// Busca productos por nombre
  Future<Either<Failure, List<Product>>> searchProducts(String query);

  /// Obtiene productos con stock bajo
  Future<Either<Failure, List<Product>>> getLowStockProducts();
}
