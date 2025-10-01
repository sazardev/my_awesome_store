import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_awesome_store/core/errors/failures.dart';
import 'package:my_awesome_store/features/products/domain/repositories/product_repository.dart';

/// Caso de uso: Eliminar un producto
@lazySingleton
class DeleteProductUseCase {
  DeleteProductUseCase(this.repository);
  final ProductRepository repository;

  Future<Either<Failure, Unit>> call(String id) {
    return repository.deleteProduct(id);
  }
}
