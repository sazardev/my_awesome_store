import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';

part 'app_database.g.dart';

/// Tabla de Productos para la base de datos
class Products extends Table {
  /// ID único del producto (UUID)
  TextColumn get id => text()();

  /// Nombre del producto
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// Precio del producto (debe ser mayor a 0)
  RealColumn get price => real()();

  /// Stock disponible (por defecto 0)
  IntColumn get stock => integer().withDefault(const Constant(0))();

  /// Descripción opcional del producto
  TextColumn get description => text().nullable()();

  /// Código de barras o QR
  TextColumn get barcode => text().nullable()();

  /// Categoría del producto
  TextColumn get category => text().nullable()();

  /// Rack o ubicación física
  TextColumn get rackLocation => text().nullable()();

  /// Fecha de creación
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Fecha de última actualización
  DateTimeColumn get updatedAt => dateTime().nullable()();

  /// Clave primaria
  @override
  Set<Column> get primaryKey => {id};

  /// Índices para mejorar búsquedas
  @override
  List<Set<Column>> get uniqueKeys => [
    {barcode}, // Barcode debe ser único si existe
  ];
}

/// Tabla de Categorías
class Categories extends Table {
  /// ID único de la categoría
  TextColumn get id => text()();

  /// Nombre de la categoría
  TextColumn get name => text().withLength(min: 1, max: 50)();

  /// Descripción de la categoría
  TextColumn get description => text().nullable()();

  /// Color representativo (en formato hexadecimal)
  TextColumn get colorHex => text().nullable()();

  /// Fecha de creación
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {name}, // Nombre único
  ];
}

/// Tabla de Ventas
class Sales extends Table {
  /// ID único de la venta
  TextColumn get id => text()();

  /// Total de la venta
  RealColumn get total => real()();

  /// Fecha y hora de la venta
  DateTimeColumn get saleDate => dateTime().withDefault(currentDateAndTime)();

  /// Método de pago (efectivo, tarjeta, etc.)
  TextColumn get paymentMethod => text().nullable()();

  /// Notas adicionales
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tabla de Items de Venta (relación muchos a muchos entre Sales y Products)
class SaleItems extends Table {
  /// ID único del item
  TextColumn get id => text()();

  /// ID de la venta (foreign key)
  TextColumn get saleId =>
      text().references(Sales, #id, onDelete: KeyAction.cascade)();

  /// ID del producto (foreign key)
  TextColumn get productId => text().references(Products, #id)();

  /// Cantidad vendida
  IntColumn get quantity => integer()();

  /// Precio unitario al momento de la venta
  RealColumn get unitPrice => real()();

  /// Subtotal (quantity * unitPrice)
  RealColumn get subtotal => real()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Base de datos principal de la aplicación
@DriftDatabase(tables: [Products, Categories, Sales, SaleItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Migraciones de base de datos
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      // Crear todas las tablas
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Agregar migraciones aquí cuando actualices el schema
      // Ejemplo:
      // if (from < 2) {
      //   await m.addColumn(products, products.newColumn);
      // }
    },
    beforeOpen: (details) async {
      // Habilitar foreign keys en SQLite
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// Métodos helper para la base de datos pueden ir aquí
  /// Por ejemplo: consultas complejas, transacciones, etc.
}

/// Módulo Injectable para registrar la base de datos
@module
abstract class DatabaseModule {
  /// Proporciona una instancia singleton de la base de datos
  @lazySingleton
  AppDatabase get database => AppDatabase();
}

/// Función para abrir la conexión a la base de datos
QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'my_awesome_store_db',
    // Configuración para web
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
      onResult: (result) {
        if (result.missingFeatures.isNotEmpty) {
          // Alertar si faltan características en web
          // ignore: avoid_print
          print('Missing features in web: ${result.missingFeatures}');
        }
      },
    ),
  );
}
