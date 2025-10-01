import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_awesome_store/core/errors/failures.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';
import 'package:my_awesome_store/features/products/domain/repositories/product_repository.dart';

/// Caso de uso: Actualizar un producto
@lazySingleton
class UpdateProductUseCase {
  UpdateProductUseCase(this.repository);
  final ProductRepository repository;

  Future<Either<Failure, Unit>> call(Product product) {
    return repository.updateProduct(product);
  }
}
