import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_awesome_store/core/errors/failures.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';
import 'package:my_awesome_store/features/products/domain/repositories/product_repository.dart';

/// Caso de uso: Obtener un producto por ID
@lazySingleton
class GetProductById {
  GetProductById(this.repository);
  final ProductRepository repository;

  Future<Either<Failure, Product>> call(String id) {
    return repository.getProductById(id);
  }
}
