import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_awesome_store/core/errors/failures.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';
import 'package:my_awesome_store/features/products/domain/repositories/product_repository.dart';

/// Caso de uso: Obtener todos los productos
@lazySingleton
class GetProducts {
  GetProducts(this.repository);
  final ProductRepository repository;

  Future<Either<Failure, List<Product>>> call() {
    return repository.getProducts();
  }
}
