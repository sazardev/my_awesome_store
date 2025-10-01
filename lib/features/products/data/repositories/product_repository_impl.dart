import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_awesome_store/core/errors/exceptions.dart';
import 'package:my_awesome_store/core/errors/failures.dart';
import 'package:my_awesome_store/features/products/data/datasources/product_local_datasource.dart';
import 'package:my_awesome_store/features/products/data/models/product_model.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';
import 'package:my_awesome_store/features/products/domain/repositories/product_repository.dart';

/// Implementación del repositorio de productos
@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this.localDataSource);
  final ProductLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final productModels = await localDataSource.getProducts();
      final products = productModels.map((model) => model.toEntity()).toList();
      return Right(products);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure( e.message));
    } catch (e) {
      return Left(UnexpectedFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      final productModel = await localDataSource.getProductById(id);
      return Right(productModel.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure( e.message));
    } catch (e) {
      return Left(UnexpectedFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addProduct(Product product) async {
    try {
      final productModel = ProductModel.fromEntity(product);
      await localDataSource.addProduct(productModel);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure( e.message));
    } catch (e) {
      return Left(UnexpectedFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProduct(Product product) async {
    try {
      final productModel = ProductModel.fromEntity(product);
      await localDataSource.updateProduct(productModel);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure( e.message));
    } catch (e) {
      return Left(UnexpectedFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    try {
      await localDataSource.deleteProduct(id);
      return const Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure( e.message));
    } catch (e) {
      return Left(UnexpectedFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    try {
      final productModels = await localDataSource.searchProducts(query);
      final products = productModels.map((model) => model.toEntity()).toList();
      return Right(products);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure( e.message));
    } catch (e) {
      return Left(UnexpectedFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getLowStockProducts() async {
    try {
      final productModels = await localDataSource.getLowStockProducts();
      final products = productModels.map((model) => model.toEntity()).toList();
      return Right(products);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure( e.message));
    } catch (e) {
      return Left(UnexpectedFailure( e.toString()));
    }
  }
}
