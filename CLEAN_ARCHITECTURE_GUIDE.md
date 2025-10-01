# 🏗️ Clean Architecture Guide - My Awesome Store

## 📦 Paquetes Instalados

### 🎯 Estado y BLoC Pattern
- **flutter_bloc** (v9.1.1) - Implementación del patrón BLoC para gestión de estado
- **bloc_test** (v10.0.0) - Testing para BLoCs

### 💉 Inyección de Dependencias
- **get_it** (v8.2.0) - Service Locator para inversión de dependencias
- **injectable** (v2.5.2) - Anotaciones para DI
- **injectable_generator** (v2.8.1) - Generador de código para DI

### 🗄️ Base de Datos (SQLite)
- **drift** (v2.28.2) - ORM moderno y reactivo para SQLite
- **drift_flutter** (v0.2.7) - Integración de Drift con Flutter
- **drift_dev** (v2.28.3) - Generador de código para Drift

### 🔧 Programación Funcional
- **fpdart** (v1.1.1) - Programación funcional (Either, Option, Result)
  - Manejo de errores type-safe
  - Railway Oriented Programming

### 🧊 Inmutabilidad y Serialización
- **freezed** (v3.2.3) - Clases inmutables, copyWith, pattern matching
- **freezed_annotation** (v3.1.0) - Anotaciones para Freezed
- **json_serializable** (v6.11.1) - Serialización JSON
- **json_annotation** (v4.9.0) - Anotaciones para JSON

### 🛠️ Utilidades
- **equatable** (v2.0.7) - Comparación de valores sin boilerplate
- **logger** (v2.6.1) - Logging estructurado y configurable
- **build_runner** (v2.7.1) - Ejecutor de generadores de código

### 📏 Calidad de Código
- **very_good_analysis** (v10.0.0) - Reglas de lint estrictas y profesionales

---

## 🏛️ Estructura de Clean Architecture

```
lib/
├── core/                          # Núcleo compartido
│   ├── di/                        # Inyección de dependencias
│   │   ├── injection_container.dart
│   │   └── injection_container.config.dart (generado)
│   ├── errors/                    # Manejo de errores
│   │   ├── failures.dart
│   │   └── exceptions.dart
│   ├── network/                   # Cliente HTTP
│   ├── database/                  # Configuración de DB
│   │   └── app_database.dart
│   └── utils/                     # Utilidades compartidas
│       ├── constants.dart
│       ├── logger.dart
│       └── extensions.dart
│
├── features/                      # Características por módulo
│   └── products/                  # Ejemplo: Feature de productos
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── product_local_datasource.dart
│       │   │   └── product_remote_datasource.dart
│       │   ├── models/
│       │   │   └── product_model.dart (con freezed)
│       │   └── repositories/
│       │       └── product_repository_impl.dart
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   └── product.dart (con freezed)
│       │   ├── repositories/
│       │   │   └── product_repository.dart (abstract)
│       │   └── usecases/
│       │       ├── get_products.dart
│       │       ├── add_product.dart
│       │       └── delete_product.dart
│       │
│       └── presentation/
│           ├── bloc/
│           │   ├── product_bloc.dart
│           │   ├── product_event.dart
│           │   └── product_state.dart
│           ├── pages/
│           │   ├── products_page.dart
│           │   └── product_detail_page.dart
│           └── widgets/
│               └── product_card.dart
│
└── main.dart                      # Entry point
```

---

## 📚 Guía de Uso por Capa

### 1️⃣ **Domain Layer** (Entidades y Lógica de Negocio)

#### Entities con Freezed
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required double price,
    required int stock,
    String? description,
  }) = _Product;
}
```

#### UseCase con Either (fpdart)
```dart
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProducts {
  final ProductRepository _repository;

  GetProducts(this._repository);

  Future<Either<Failure, List<Product>>> call() async {
    return _repository.getProducts();
  }
}
```

#### Repository Interface
```dart
import 'package:fpdart/fpdart.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> getProductById(String id);
  Future<Either<Failure, Unit>> addProduct(Product product);
  Future<Either<Failure, Unit>> deleteProduct(String id);
}
```

---

### 2️⃣ **Data Layer** (Implementaciones)

#### Model con Freezed + JSON
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
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  // Mapper to Entity
  Product toEntity() => Product(
        id: id,
        name: name,
        price: price,
        stock: stock,
        description: description,
      );

  // Mapper from Entity
  factory ProductModel.fromEntity(Product entity) => ProductModel(
        id: entity.id,
        name: entity.name,
        price: entity.price,
        stock: entity.stock,
        description: entity.description,
      );
}
```

#### Drift Database Table
```dart
import 'package:drift/drift.dart';

class Products extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get price => real()();
  IntColumn get stock => integer()();
  TextColumn get description => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Products])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
```

#### Repository Implementation
```dart
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource _localDataSource;
  final ProductRemoteDataSource _remoteDataSource;
  final Logger _logger;

  ProductRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
    this._logger,
  );

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final products = await _localDataSource.getProducts();
      return right(products.map((m) => m.toEntity()).toList());
    } on DatabaseException catch (e) {
      _logger.e('Database error: $e');
      return left(DatabaseFailure(e.toString()));
    } catch (e) {
      _logger.e('Unexpected error: $e');
      return left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addProduct(Product product) async {
    try {
      final model = ProductModel.fromEntity(product);
      await _localDataSource.addProduct(model);
      return right(unit);
    } catch (e) {
      _logger.e('Error adding product: $e');
      return left(DatabaseFailure(e.toString()));
    }
  }
}
```

---

### 3️⃣ **Presentation Layer** (BLoC)

#### Events
```dart
part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.loadProducts() = _LoadProducts;
  const factory ProductEvent.addProduct(Product product) = _AddProduct;
  const factory ProductEvent.deleteProduct(String id) = _DeleteProduct;
}
```

#### States
```dart
part of 'product_bloc.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;
  const factory ProductState.loaded(List<Product> products) = _Loaded;
  const factory ProductState.error(String message) = _Error;
}
```

#### BLoC
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts _getProducts;
  final AddProduct _addProduct;
  final DeleteProduct _deleteProduct;
  final Logger _logger;

  ProductBloc(
    this._getProducts,
    this._addProduct,
    this._deleteProduct,
    this._logger,
  ) : super(const ProductState.initial()) {
    on<_LoadProducts>(_onLoadProducts);
    on<_AddProduct>(_onAddProduct);
    on<_DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onLoadProducts(
    _LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductState.loading());
    
    final result = await _getProducts();
    
    result.fold(
      (failure) {
        _logger.e('Failed to load products: ${failure.message}');
        emit(ProductState.error(failure.message));
      },
      (products) => emit(ProductState.loaded(products)),
    );
  }

  Future<void> _onAddProduct(
    _AddProduct event,
    Emitter<ProductState> emit,
  ) async {
    final result = await _addProduct(event.product);
    
    result.fold(
      (failure) => emit(ProductState.error(failure.message)),
      (_) => add(const ProductEvent.loadProducts()),
    );
  }
}
```

---

### 4️⃣ **Dependency Injection**

#### injection_container.dart
```dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // Configurar Logger
  getIt.registerLazySingleton<Logger>(
    () => Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 50,
        colors: true,
        printEmojis: true,
      ),
    ),
  );

  // Inicializar inyección generada
  await getIt.init();
}
```

#### Generar código
```bash
# Generar todo el código (Freezed, Injectable, Drift, etc.)
flutter pub run build_runner build --delete-conflicting-outputs
```

---

### 5️⃣ **Main.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart';
import 'features/products/presentation/bloc/product_bloc.dart';
import 'features/products/presentation/pages/products_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configurar dependencias
  await configureDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Awesome Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => getIt<ProductBloc>()
          ..add(const ProductEvent.loadProducts()),
        child: const ProductsPage(),
      ),
    );
  }
}
```

---

## 🎯 Principios de Clean Architecture

### ✅ Dependency Rule
- **Las dependencias apuntan hacia adentro**: Domain ← Data ← Presentation
- **Domain no depende de nadie**: Es el núcleo puro
- **Data implementa interfaces de Domain**
- **Presentation usa UseCases de Domain**

### ✅ SOLID Principles
- **S**ingle Responsibility: Cada clase tiene una única responsabilidad
- **O**pen/Closed: Abierto para extensión, cerrado para modificación
- **L**iskov Substitution: Las implementaciones son intercambiables
- **I**nterface Segregation: Interfaces pequeñas y específicas
- **D**ependency Inversion: Depende de abstracciones, no de implementaciones

### ✅ Separation of Concerns
- **Domain**: Lógica de negocio pura
- **Data**: Acceso a datos (DB, API, Cache)
- **Presentation**: UI y gestión de estado

---

## 🚀 Comandos Útiles

```bash
# Instalar dependencias
flutter pub get

# Generar código (Freezed, Injectable, Drift, JSON)
flutter pub run build_runner build --delete-conflicting-outputs

# Limpiar caché y regenerar
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs

# Analizar código con linter
flutter analyze

# Aplicar fixes automáticos
dart fix --apply

# Formatear código
dart format .

# Ejecutar tests
flutter test

# Generar coverage
flutter test --coverage
```

---

## 📖 Recursos Adicionales

- [BLoC Pattern - Official Docs](https://bloclibrary.dev)
- [Clean Architecture - Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Drift Documentation](https://drift.simonbinder.eu/)
- [FPDart - Functional Programming](https://pub.dev/packages/fpdart)
- [Injectable - DI Setup](https://pub.dev/packages/injectable)
- [Freezed - Immutable Classes](https://pub.dev/packages/freezed)

---

## 💡 Best Practices

1. **Usa Either para manejo de errores** en lugar de try-catch en el dominio
2. **Crea UseCases pequeños** y específicos (1 operación = 1 UseCase)
3. **Separa Models de Entities**: Models en Data, Entities en Domain
4. **Usa Freezed** para todas las clases de datos (inmutabilidad garantizada)
5. **Inyecta dependencias** siempre con @injectable
6. **Logger todo**: Usa el logger para debugging y tracking
7. **Tests unitarios**: Escribe tests para UseCases y BLoCs
8. **Nombra correctamente**: Usa nombres descriptivos y consistentes

---

¡Tu proyecto ahora está configurado con las mejores prácticas de Clean Architecture! 🎉
