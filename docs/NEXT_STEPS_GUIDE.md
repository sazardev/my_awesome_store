# 🚀 Guía de Próximos Pasos - Implementar Feature de Productos

Esta guía te llevará paso a paso para implementar tu primer feature completo usando Clean Architecture.

---

## 📋 Tabla de Contenidos

1. [Estructura del Feature](#1-estructura-del-feature)
2. [Paso 1: Domain Layer](#2-paso-1-domain-layer)
3. [Paso 2: Data Layer](#3-paso-2-data-layer)
4. [Paso 3: Presentation Layer](#4-paso-3-presentation-layer)
5. [Paso 4: Registrar en DI](#5-paso-4-registrar-en-di)
6. [Paso 5: Crear UI](#6-paso-5-crear-ui)
7. [Comandos Útiles](#7-comandos-útiles)

---

## 1. Estructura del Feature

Ya tienes la estructura de carpetas creada en:
```
lib/features/products/
├── domain/
│   ├── entities/        # Modelos de negocio puros
│   ├── repositories/    # Interfaces (contratos)
│   └── usecases/        # Casos de uso de negocio
├── data/
│   ├── datasources/     # Fuentes de datos (DB, API)
│   ├── models/          # Modelos con serialización
│   └── repositories/    # Implementaciones de repositories
└── presentation/
    ├── bloc/            # BLoC (state management)
    ├── pages/           # Pantallas
    └── widgets/         # Widgets reutilizables
```

---

## 2. Paso 1: Domain Layer

### 2.1 Crear la Entidad (`lib/features/products/domain/entities/product.dart`)

```dart
import 'package:equatable/equatable.dart';

/// Entidad de dominio para Producto
/// Representa el concepto de negocio puro, sin dependencias externas
class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    this.description,
    this.barcode,
    this.category,
    this.rackLocation,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final double price;
  final int stock;
  final String? description;
  final String? barcode;
  final String? category;
  final String? rackLocation;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Indica si el producto está con stock bajo (menos de 10 unidades)
  bool get isLowStock => stock < 10;

  /// Indica si el producto está sin stock
  bool get isOutOfStock => stock == 0;

  /// Precio formateado
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        stock,
        description,
        barcode,
        category,
        rackLocation,
        createdAt,
        updatedAt,
      ];
}
```

### 2.2 Crear el Repository Interface (`lib/features/products/domain/repositories/product_repository.dart`)

```dart
import 'package:fpdart/fpdart.dart';
import 'package:my_awesome_store/core/errors/failures.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';

/// Contrato del repositorio de productos
/// Define las operaciones que se pueden realizar con productos
abstract class ProductRepository {
  /// Obtiene todos los productos
  Future<Either<Failure, List<Product>>> getAllProducts();

  /// Obtiene un producto por su ID
  Future<Either<Failure, Product>> getProductById(int id);

  /// Busca productos por nombre
  Future<Either<Failure, List<Product>>> searchProducts(String query);

  /// Obtiene productos con stock bajo (menos de 10)
  Future<Either<Failure, List<Product>>> getLowStockProducts();

  /// Crea un nuevo producto
  Future<Either<Failure, Product>> createProduct(Product product);

  /// Actualiza un producto existente
  Future<Either<Failure, Product>> updateProduct(Product product);

  /// Elimina un producto por su ID
  Future<Either<Failure, void>> deleteProduct(int id);

  /// Actualiza el stock de un producto
  Future<Either<Failure, Product>> updateStock(int productId, int newStock);
}
```

### 2.3 Crear Use Cases (`lib/features/products/domain/usecases/`)

**`get_all_products.dart`:**
```dart
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_awesome_store/core/errors/failures.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';
import 'package:my_awesome_store/features/products/domain/repositories/product_repository.dart';

/// Caso de uso para obtener todos los productos
@lazySingleton
class GetAllProducts {
  const GetAllProducts(this._repository);

  final ProductRepository _repository;

  /// Ejecuta el caso de uso
  Future<Either<Failure, List<Product>>> call() async {
    return _repository.getAllProducts();
  }
}
```

**`create_product.dart`:**
```dart
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_awesome_store/core/errors/failures.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';
import 'package:my_awesome_store/features/products/domain/repositories/product_repository.dart';

/// Caso de uso para crear un nuevo producto
@lazySingleton
class CreateProduct {
  const CreateProduct(this._repository);

  final ProductRepository _repository;

  /// Ejecuta el caso de uso
  Future<Either<Failure, Product>> call(Product product) async {
    // Validaciones de negocio
    if (product.name.isEmpty) {
      return left(const Failure.validation(
        message: 'El nombre del producto no puede estar vacío',
      ));
    }

    if (product.price < 0) {
      return left(const Failure.validation(
        message: 'El precio debe ser mayor o igual a cero',
      ));
    }

    if (product.stock < 0) {
      return left(const Failure.validation(
        message: 'El stock debe ser mayor o igual a cero',
      ));
    }

    return _repository.createProduct(product);
  }
}
```

**`get_low_stock_products.dart`:**
```dart
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_awesome_store/core/errors/failures.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';
import 'package:my_awesome_store/features/products/domain/repositories/product_repository.dart';

/// Caso de uso para obtener productos con stock bajo
@lazySingleton
class GetLowStockProducts {
  const GetLowStockProducts(this._repository);

  final ProductRepository _repository;

  /// Ejecuta el caso de uso
  Future<Either<Failure, List<Product>>> call() async {
    return _repository.getLowStockProducts();
  }
}
```

---

## 3. Paso 2: Data Layer

### 3.1 Crear el Modelo (`lib/features/products/data/models/product_model.dart`)

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_awesome_store/core/database/app_database.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

/// Modelo de datos para Producto con serialización
@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    required int id,
    required String name,
    required double price,
    required int stock,
    String? description,
    String? barcode,
    String? category,
    String? rackLocation,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProductModel;

  /// Crea un ProductModel desde JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  /// Convierte a entidad de dominio
  Product toEntity() => Product(
        id: id,
        name: name,
        price: price,
        stock: stock,
        description: description,
        barcode: barcode,
        category: category,
        rackLocation: rackLocation,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// Crea un ProductModel desde una entidad
  factory ProductModel.fromEntity(Product product) => ProductModel(
        id: product.id,
        name: product.name,
        price: product.price,
        stock: product.stock,
        description: product.description,
        barcode: product.barcode,
        category: product.category,
        rackLocation: product.rackLocation,
        createdAt: product.createdAt,
        updatedAt: product.updatedAt,
      );

  /// Crea un ProductModel desde una fila de Drift
  factory ProductModel.fromDrift(ProductData data) => ProductModel(
        id: data.id,
        name: data.name,
        price: data.price,
        stock: data.stock,
        description: data.description,
        barcode: data.barcode,
        category: data.category,
        rackLocation: data.rackLocation,
        createdAt: data.createdAt,
        updatedAt: data.updatedAt,
      );

  /// Convierte a companion de Drift para inserts/updates
  ProductsCompanion toDriftCompanion() => ProductsCompanion.insert(
        id: Value(id),
        name: name,
        price: price,
        stock: stock,
        description: Value(description),
        barcode: Value(barcode),
        category: Value(category),
        rackLocation: Value(rackLocation),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
```

### 3.2 Crear el DataSource (`lib/features/products/data/datasources/product_local_datasource.dart`)

```dart
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:my_awesome_store/core/database/app_database.dart';
import 'package:my_awesome_store/core/errors/exceptions.dart';
import 'package:my_awesome_store/features/products/data/models/product_model.dart';

/// Contrato del datasource local de productos
abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(int id);
  Future<List<ProductModel>> searchProducts(String query);
  Future<List<ProductModel>> getLowStockProducts();
  Future<ProductModel> createProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<void> deleteProduct(int id);
}

/// Implementación del datasource local usando Drift
@LazySingleton(as: ProductLocalDataSource)
class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  const ProductLocalDataSourceImpl(this._database);

  final AppDatabase _database;

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final products = await _database.select(_database.products).get();
      return products.map(ProductModel.fromDrift).toList();
    } catch (e) {
      throw DatabaseException('Error al obtener productos', details: e.toString());
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final product = await (_database.select(_database.products)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingle();
      return ProductModel.fromDrift(product);
    } catch (e) {
      throw DatabaseException('Error al obtener producto con ID $id', details: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final products = await (_database.select(_database.products)
            ..where((tbl) => tbl.name.like('%$query%')))
          .get();
      return products.map(ProductModel.fromDrift).toList();
    } catch (e) {
      throw DatabaseException('Error al buscar productos', details: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getLowStockProducts() async {
    try {
      final products = await (_database.select(_database.products)
            ..where((tbl) => tbl.stock.isSmallerThanValue(10)))
          .get();
      return products.map(ProductModel.fromDrift).toList();
    } catch (e) {
      throw DatabaseException('Error al obtener productos con stock bajo', details: e.toString());
    }
  }

  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    try {
      final companion = product.toDriftCompanion();
      final id = await _database.into(_database.products).insert(companion);
      return product.copyWith(id: id);
    } catch (e) {
      throw DatabaseException('Error al crear producto', details: e.toString());
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      final updatedProduct = product.copyWith(updatedAt: DateTime.now());
      await _database.update(_database.products).replace(updatedProduct.toDriftCompanion() as ProductData);
      return updatedProduct;
    } catch (e) {
      throw DatabaseException('Error al actualizar producto', details: e.toString());
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    try {
      await (_database.delete(_database.products)
            ..where((tbl) => tbl.id.equals(id)))
          .go();
    } catch (e) {
      throw DatabaseException('Error al eliminar producto', details: e.toString());
    }
  }
}
```

### 3.3 Implementar el Repository (`lib/features/products/data/repositories/product_repository_impl.dart`)

```dart
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
  const ProductRepositoryImpl(this._localDataSource);

  final ProductLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final products = await _localDataSource.getAllProducts();
      return right(products.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return left(Failure.database(message: e.message, details: e.details));
    } catch (e) {
      return left(Failure.unexpected(message: e.toString(), error: e));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async {
    try {
      final product = await _localDataSource.getProductById(id);
      return right(product.toEntity());
    } on DatabaseException catch (e) {
      return left(Failure.database(message: e.message, details: e.details));
    } catch (e) {
      return left(Failure.unexpected(message: e.toString(), error: e));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    try {
      final products = await _localDataSource.searchProducts(query);
      return right(products.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return left(Failure.database(message: e.message, details: e.details));
    } catch (e) {
      return left(Failure.unexpected(message: e.toString(), error: e));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getLowStockProducts() async {
    try {
      final products = await _localDataSource.getLowStockProducts();
      return right(products.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return left(Failure.database(message: e.message, details: e.details));
    } catch (e) {
      return left(Failure.unexpected(message: e.toString(), error: e));
    }
  }

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {
    try {
      final model = ProductModel.fromEntity(product);
      final createdModel = await _localDataSource.createProduct(model);
      return right(createdModel.toEntity());
    } on DatabaseException catch (e) {
      return left(Failure.database(message: e.message, details: e.details));
    } catch (e) {
      return left(Failure.unexpected(message: e.toString(), error: e));
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    try {
      final model = ProductModel.fromEntity(product);
      final updatedModel = await _localDataSource.updateProduct(model);
      return right(updatedModel.toEntity());
    } on DatabaseException catch (e) {
      return left(Failure.database(message: e.message, details: e.details));
    } catch (e) {
      return left(Failure.unexpected(message: e.toString(), error: e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    try {
      await _localDataSource.deleteProduct(id);
      return right(null);
    } on DatabaseException catch (e) {
      return left(Failure.database(message: e.message, details: e.details));
    } catch (e) {
      return left(Failure.unexpected(message: e.toString(), error: e));
    }
  }

  @override
  Future<Either<Failure, Product>> updateStock(int productId, int newStock) async {
    try {
      final productResult = await getProductById(productId);
      return productResult.fold(
        (failure) => left(failure),
        (product) async {
          final updatedProduct = Product(
            id: product.id,
            name: product.name,
            price: product.price,
            stock: newStock,
            description: product.description,
            barcode: product.barcode,
            category: product.category,
            rackLocation: product.rackLocation,
            createdAt: product.createdAt,
            updatedAt: DateTime.now(),
          );
          return updateProduct(updatedProduct);
        },
      );
    } catch (e) {
      return left(Failure.unexpected(message: e.toString(), error: e));
    }
  }
}
```

---

## 4. Paso 3: Presentation Layer

### 4.1 Crear el BLoC (`lib/features/products/presentation/bloc/product_bloc.dart`)

**Eventos:**
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';

part 'product_event.freezed.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.loadProducts() = LoadProducts;
  const factory ProductEvent.loadLowStockProducts() = LoadLowStockProducts;
  const factory ProductEvent.searchProducts(String query) = SearchProducts;
  const factory ProductEvent.createProduct(Product product) = CreateProduct;
  const factory ProductEvent.updateProduct(Product product) = UpdateProduct;
  const factory ProductEvent.deleteProduct(int id) = DeleteProduct;
}
```

**Estados:**
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_awesome_store/core/errors/failures.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = ProductInitial;
  const factory ProductState.loading() = ProductLoading;
  const factory ProductState.loaded(List<Product> products) = ProductLoaded;
  const factory ProductState.error(Failure failure) = ProductError;
  const factory ProductState.operationSuccess(String message) = ProductOperationSuccess;
}
```

**BLoC:**
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_awesome_store/features/products/domain/usecases/create_product.dart';
import 'package:my_awesome_store/features/products/domain/usecases/get_all_products.dart';
import 'package:my_awesome_store/features/products/domain/usecases/get_low_stock_products.dart';
import 'package:my_awesome_store/features/products/presentation/bloc/product_event.dart';
import 'package:my_awesome_store/features/products/presentation/bloc/product_state.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(
    this._getAllProducts,
    this._getLowStockProducts,
    this._createProduct,
  ) : super(const ProductState.initial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadLowStockProducts>(_onLoadLowStockProducts);
    on<CreateProduct>(_onCreateProduct);
  }

  final GetAllProducts _getAllProducts;
  final GetLowStockProducts _getLowStockProducts;
  final CreateProduct _createProduct;

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductState.loading());
    final result = await _getAllProducts();
    result.fold(
      (failure) => emit(ProductState.error(failure)),
      (products) => emit(ProductState.loaded(products)),
    );
  }

  Future<void> _onLoadLowStockProducts(
    LoadLowStockProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductState.loading());
    final result = await _getLowStockProducts();
    result.fold(
      (failure) => emit(ProductState.error(failure)),
      (products) => emit(ProductState.loaded(products)),
    );
  }

  Future<void> _onCreateProduct(
    CreateProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductState.loading());
    final result = await _createProduct(event.product);
    result.fold(
      (failure) => emit(ProductState.error(failure)),
      (product) => emit(const ProductState.operationSuccess('Producto creado exitosamente')),
    );
  }
}
```

---

## 5. Paso 4: Registrar en DI

**¡Ya está hecho!** Al usar las anotaciones `@injectable`, `@lazySingleton`, etc., el código se genera automáticamente.

Solo necesitas ejecutar:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 6. Paso 5: Crear UI

### 6.1 Página de Lista de Productos (`lib/features/products/presentation/pages/products_page.dart`)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_awesome_store/core/di/injection_container.dart';
import 'package:my_awesome_store/features/products/presentation/bloc/product_bloc.dart';
import 'package:my_awesome_store/features/products/presentation/bloc/product_event.dart';
import 'package:my_awesome_store/features/products/presentation/bloc/product_state.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductBloc>()..add(const ProductEvent.loadProducts()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Productos'),
          actions: [
            IconButton(
              icon: const Icon(Icons.warning_amber),
              onPressed: () {
                context.read<ProductBloc>().add(const ProductEvent.loadLowStockProducts());
              },
              tooltip: 'Stock bajo',
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: Text('Cargando productos...')),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (products) {
                if (products.isEmpty) {
                  return const Center(child: Text('No hay productos'));
                }
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: Icon(
                        Icons.inventory_2,
                        color: product.isOutOfStock
                            ? Colors.red
                            : product.isLowStock
                                ? Colors.orange
                                : Colors.green,
                      ),
                      title: Text(product.name),
                      subtitle: Text('Stock: ${product.stock} | ${product.formattedPrice}'),
                      trailing: product.isLowStock
                          ? const Icon(Icons.warning, color: Colors.orange)
                          : null,
                      onTap: () {
                        // TODO: Navegar a detalles
                      },
                    );
                  },
                );
              },
              error: (failure) => Center(
                child: Text('Error: ${failure.userMessage}'),
              ),
              operationSuccess: (message) => Center(child: Text(message)),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO: Navegar a crear producto
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
```

---

## 7. Comandos Útiles

### Generar Código
```bash
# Generar todo el código (Freezed, JSON, Injectable, Drift)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (regenera automáticamente al guardar)
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Analizar Código
```bash
# Analizar errores y warnings
flutter analyze

# Formatear código
dart format .

# Fix automático de algunos problemas
dart fix --apply
```

### Ejecutar App
```bash
# Ejecutar en modo debug
flutter run

# Ejecutar en modo release
flutter run --release

# Hot reload (automático al guardar)
# Presiona 'r' en la terminal después de cambios
```

### Testing
```bash
# Ejecutar tests
flutter test

# Ejecutar tests con cobertura
flutter test --coverage
```

---

## 8. Checklist de Implementación

- [ ] **Domain Layer**
  - [ ] Crear entidad `Product`
  - [ ] Crear interfaz `ProductRepository`
  - [ ] Crear use case `GetAllProducts`
  - [ ] Crear use case `CreateProduct`
  - [ ] Crear use case `GetLowStockProducts`

- [ ] **Data Layer**
  - [ ] Crear modelo `ProductModel` con Freezed
  - [ ] Crear interfaz `ProductLocalDataSource`
  - [ ] Implementar `ProductLocalDataSourceImpl`
  - [ ] Implementar `ProductRepositoryImpl`

- [ ] **Presentation Layer**
  - [ ] Crear eventos `ProductEvent` con Freezed
  - [ ] Crear estados `ProductState` con Freezed
  - [ ] Crear `ProductBloc`
  - [ ] Crear página `ProductsPage`
  - [ ] Crear widgets personalizados

- [ ] **Generación y Testing**
  - [ ] Ejecutar `build_runner`
  - [ ] Verificar con `flutter analyze`
  - [ ] Compilar con `flutter build apk --debug`
  - [ ] Probar en emulador/dispositivo

---

## 9. Tips y Buenas Prácticas

### ✅ DO
- Usa `const` siempre que sea posible
- Maneja todos los casos en `Either` con `.fold()`
- Usa pattern matching con Freezed (`.when()`)
- Valida datos en los Use Cases
- Captura excepciones específicas en el Repository
- Usa `@injectable` para DI automático

### ❌ DON'T
- No mezcles lógica de negocio en el BLoC
- No accedas directamente al DataSource desde el BLoC
- No uses `print()` para debugging (usa `Logger`)
- No ignores errores con `.getOrElse()` sin manejarlos
- No pongas lógica de UI en los Use Cases

---

## 10. Solución de Problemas

### Error: "Missing required parameter"
**Solución:** Ejecuta `flutter pub run build_runner clean` y luego regenera.

### Error: "Type X is not a subtype of Y"
**Solución:** Verifica que hayas convertido correctamente entre Model y Entity.

### Error: "GetIt: Object/factory with type X is not registered"
**Solución:** Ejecuta `flutter pub run build_runner build` para regenerar DI.

### La app no compila después de cambios
**Solución:**
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

---

## 🎯 ¡Siguiente Paso!

Ahora tienes toda la información para implementar el feature de Productos. ¡Comienza por el Domain Layer y sigue la guía paso a paso!

**¡Buena suerte! 🚀**
