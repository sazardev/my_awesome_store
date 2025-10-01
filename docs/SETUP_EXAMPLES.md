# 🔧 Ejemplos de Configuración Inicial

## 📦 Build Runner Configuration

Crea el archivo `build.yaml` en la raíz del proyecto:

```yaml
targets:
  $default:
    builders:
      freezed:
        enabled: true
        options:
          # Opciones de Freezed
          union_key: 'type'
          union_value_case: 'FreezedUnionCase.pascal'
      
      json_serializable:
        enabled: true
        options:
          # Opciones de JSON Serializable
          any_map: false
          checked: true
          create_factory: true
          create_to_json: true
          disallow_unrecognized_keys: false
          explicit_to_json: true
          field_rename: 'none'
          generic_argument_factories: true
          ignore_unannotated: false
          
      injectable_generator:injectable:
        enabled: true
        
      drift_dev:
        enabled: true
        options:
          store_date_time_values_as_text: true
```

---

## 🏗️ Core Setup Examples

### 1. Failures (core/errors/failures.dart)

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const Failure._();

  const factory Failure.server(String message) = ServerFailure;
  const factory Failure.database(String message) = DatabaseFailure;
  const factory Failure.network(String message) = NetworkFailure;
  const factory Failure.cache(String message) = CacheFailure;
  const factory Failure.unexpected(String message) = UnexpectedFailure;

  String get message => when(
        server: (msg) => 'Error del servidor: $msg',
        database: (msg) => 'Error de base de datos: $msg',
        network: (msg) => 'Error de conexión: $msg',
        cache: (msg) => 'Error de caché: $msg',
        unexpected: (msg) => 'Error inesperado: $msg',
      );
}
```

### 2. Exceptions (core/errors/exceptions.dart)

```dart
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}
```

### 3. Logger Setup (core/utils/logger_config.dart)

```dart
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class LoggerModule {
  @lazySingleton
  Logger get logger => Logger(
        printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          printTime: true,
        ),
        level: Level.debug, // Cambiar a Level.info en producción
      );
}
```

### 4. App Database (core/database/app_database.dart)

```dart
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';

part 'app_database.g.dart';

// Define tus tablas aquí
class Products extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  RealColumn get price => real().check(price.isBiggerThanValue(0))();
  IntColumn get stock => integer().withDefault(const Constant(0))();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Products])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Manejar migraciones aquí
        },
      );
}

@module
abstract class DatabaseModule {
  @lazySingleton
  AppDatabase get database => AppDatabase(
        driftDatabase(
          name: 'my_awesome_store_db',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );
}
```

### 5. Dependency Injection Container (core/di/injection_container.dart)

```dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();
```

---

## 🎯 Feature Example: Products

### Domain Layer

#### Entity (domain/entities/product.dart)
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

@freezed
class Product with _$Product {
  const Product._();

  const factory Product({
    required String id,
    required String name,
    required double price,
    required int stock,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Product;

  // Business logic methods
  bool get isInStock => stock > 0;
  bool get isLowStock => stock > 0 && stock < 10;
  bool get isOutOfStock => stock == 0;

  String get stockStatus {
    if (isOutOfStock) return 'Sin stock';
    if (isLowStock) return 'Stock bajo';
    return 'En stock';
  }
}
```

#### Repository Interface (domain/repositories/product_repository.dart)
```dart
import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Product>> getProductById(String id);
  Future<Either<Failure, List<Product>>> searchProducts(String query);
  Future<Either<Failure, Unit>> addProduct(Product product);
  Future<Either<Failure, Unit>> updateProduct(Product product);
  Future<Either<Failure, Unit>> deleteProduct(String id);
  Stream<Either<Failure, List<Product>>> watchAllProducts();
}
```

#### UseCases
```dart
// domain/usecases/get_all_products.dart
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

@injectable
class GetAllProducts {
  final ProductRepository _repository;

  GetAllProducts(this._repository);

  Future<Either<Failure, List<Product>>> call() async {
    return _repository.getAllProducts();
  }
}

// domain/usecases/add_product.dart
@injectable
class AddProduct {
  final ProductRepository _repository;

  AddProduct(this._repository);

  Future<Either<Failure, Unit>> call(Product product) async {
    return _repository.addProduct(product);
  }
}

// domain/usecases/update_product.dart
@injectable
class UpdateProduct {
  final ProductRepository _repository;

  UpdateProduct(this._repository);

  Future<Either<Failure, Unit>> call(Product product) async {
    return _repository.updateProduct(product);
  }
}

// domain/usecases/delete_product.dart
@injectable
class DeleteProduct {
  final ProductRepository _repository;

  DeleteProduct(this._repository);

  Future<Either<Failure, Unit>> call(String id) async {
    return _repository.deleteProduct(id);
  }
}

// domain/usecases/search_products.dart
@injectable
class SearchProducts {
  final ProductRepository _repository;

  SearchProducts(this._repository);

  Future<Either<Failure, List<Product>>> call(String query) async {
    return _repository.searchProducts(query);
  }
}
```

---

### Data Layer

#### Model (data/models/product_model.dart)
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    required String id,
    required String name,
    required double price,
    required int stock,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  // Mappers
  Product toEntity() => Product(
        id: id,
        name: name,
        price: price,
        stock: stock,
        description: description,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  factory ProductModel.fromEntity(Product entity) => ProductModel(
        id: entity.id,
        name: entity.name,
        price: entity.price,
        stock: entity.stock,
        description: entity.description,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
}
```

#### Local DataSource (data/datasources/product_local_datasource.dart)
```dart
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import '../../core/database/app_database.dart';
import '../../core/errors/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> searchProducts(String query);
  Future<void> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
  Stream<List<ProductModel>> watchAllProducts();
}

@LazySingleton(as: ProductLocalDataSource)
class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final AppDatabase _database;

  ProductLocalDataSourceImpl(this._database);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final products = await _database.select(_database.products).get();
      return products.map(_mapToModel).toList();
    } catch (e) {
      throw DatabaseException('Failed to get products: $e');
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final product = await (_database.select(_database.products)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
      return _mapToModel(product);
    } catch (e) {
      throw DatabaseException('Product not found: $e');
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final products = await (_database.select(_database.products)
            ..where((tbl) => tbl.name.contains(query) | 
                           tbl.description.contains(query)))
          .get();
      return products.map(_mapToModel).toList();
    } catch (e) {
      throw DatabaseException('Search failed: $e');
    }
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    try {
      await _database.into(_database.products).insert(
            ProductsCompanion.insert(
              id: product.id,
              name: product.name,
              price: product.price,
              stock: product.stock,
              description: Value(product.description),
            ),
          );
    } catch (e) {
      throw DatabaseException('Failed to add product: $e');
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      await (_database.update(_database.products)
            ..where((tbl) => tbl.id.equals(product.id)))
          .write(
        ProductsCompanion(
          name: Value(product.name),
          price: Value(product.price),
          stock: Value(product.stock),
          description: Value(product.description),
          updatedAt: Value(DateTime.now()),
        ),
      );
    } catch (e) {
      throw DatabaseException('Failed to update product: $e');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await (_database.delete(_database.products)
            ..where((tbl) => tbl.id.equals(id)))
          .go();
    } catch (e) {
      throw DatabaseException('Failed to delete product: $e');
    }
  }

  @override
  Stream<List<ProductModel>> watchAllProducts() {
    return _database.select(_database.products).watch().map(
          (products) => products.map(_mapToModel).toList(),
        );
  }

  ProductModel _mapToModel(Product product) => ProductModel(
        id: product.id,
        name: product.name,
        price: product.price,
        stock: product.stock,
        description: product.description,
        createdAt: product.createdAt,
        updatedAt: product.updatedAt,
      );
}
```

#### Repository Implementation (data/repositories/product_repository_impl.dart)
```dart
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';
import '../models/product_model.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource _localDataSource;
  final Logger _logger;

  ProductRepositoryImpl(
    this._localDataSource,
    this._logger,
  );

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final products = await _localDataSource.getAllProducts();
      return right(products.map((m) => m.toEntity()).toList());
    } on DatabaseException catch (e) {
      _logger.e('Database error getting products', error: e);
      return left(Failure.database(e.message));
    } catch (e) {
      _logger.e('Unexpected error getting products', error: e);
      return left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      final product = await _localDataSource.getProductById(id);
      return right(product.toEntity());
    } on DatabaseException catch (e) {
      _logger.e('Database error getting product', error: e);
      return left(Failure.database(e.message));
    } catch (e) {
      _logger.e('Unexpected error getting product', error: e);
      return left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    try {
      final products = await _localDataSource.searchProducts(query);
      return right(products.map((m) => m.toEntity()).toList());
    } on DatabaseException catch (e) {
      _logger.e('Database error searching products', error: e);
      return left(Failure.database(e.message));
    } catch (e) {
      _logger.e('Unexpected error searching products', error: e);
      return left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addProduct(Product product) async {
    try {
      final model = ProductModel.fromEntity(product);
      await _localDataSource.addProduct(model);
      _logger.i('Product added successfully: ${product.name}');
      return right(unit);
    } on DatabaseException catch (e) {
      _logger.e('Database error adding product', error: e);
      return left(Failure.database(e.message));
    } catch (e) {
      _logger.e('Unexpected error adding product', error: e);
      return left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProduct(Product product) async {
    try {
      final model = ProductModel.fromEntity(product);
      await _localDataSource.updateProduct(model);
      _logger.i('Product updated successfully: ${product.name}');
      return right(unit);
    } on DatabaseException catch (e) {
      _logger.e('Database error updating product', error: e);
      return left(Failure.database(e.message));
    } catch (e) {
      _logger.e('Unexpected error updating product', error: e);
      return left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    try {
      await _localDataSource.deleteProduct(id);
      _logger.i('Product deleted successfully: $id');
      return right(unit);
    } on DatabaseException catch (e) {
      _logger.e('Database error deleting product', error: e);
      return left(Failure.database(e.message));
    } catch (e) {
      _logger.e('Unexpected error deleting product', error: e);
      return left(Failure.unexpected(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Product>>> watchAllProducts() {
    return _localDataSource.watchAllProducts().map(
          (products) => right<Failure, List<Product>>(
            products.map((m) => m.toEntity()).toList(),
          ),
        );
  }
}
```

---

### Presentation Layer

Consulta el archivo `CLEAN_ARCHITECTURE_GUIDE.md` para ver ejemplos completos de BLoC, Events, States y Widgets.

---

## 🚀 Inicialización en main.dart

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar inyección de dependencias
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Awesome Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
```

---

## 🔨 Generar Código

Después de crear todos los archivos con anotaciones:

```bash
# Limpiar archivos generados anteriores
flutter pub run build_runner clean

# Generar todo el código
flutter pub run build_runner build --delete-conflicting-outputs

# O usar watch para regenerar automáticamente
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

¡Todo listo para empezar a desarrollar con Clean Architecture! 🎉
