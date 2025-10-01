// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

import '../../features/products/data/datasources/product_local_datasource.dart'
    as _i768;
import '../../features/products/data/repositories/product_repository_impl.dart'
    as _i764;
import '../../features/products/domain/repositories/product_repository.dart'
    as _i963;
import '../../features/products/domain/usecases/add_product.dart' as _i380;
import '../../features/products/domain/usecases/delete_product.dart' as _i803;
import '../../features/products/domain/usecases/get_product_by_id.dart'
    as _i147;
import '../../features/products/domain/usecases/get_products.dart' as _i143;
import '../../features/products/domain/usecases/update_product.dart' as _i1073;
import '../../features/products/presentation/bloc/product_bloc.dart' as _i28;
import '../config/env_config.dart' as _i373;
import '../database/app_database.dart' as _i982;
import '../utils/logger_config.dart' as _i594;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final databaseModule = _$DatabaseModule();
    final loggerModule = _$LoggerModule();
    final envConfigModule = _$EnvConfigModule();
    gh.lazySingleton<_i982.AppDatabase>(() => databaseModule.database);
    gh.lazySingleton<_i974.Logger>(() => loggerModule.logger);
    gh.lazySingleton<String>(
      () => envConfigModule.environment,
      instanceName: 'environment',
    );
    gh.lazySingleton<bool>(
      () => envConfigModule.enableCrashReporting,
      instanceName: 'enableCrashReporting',
    );
    gh.lazySingleton<String>(
      () => envConfigModule.apiBaseUrl,
      instanceName: 'apiBaseUrl',
    );
    gh.lazySingleton<String>(
      () => envConfigModule.appVersion,
      instanceName: 'appVersion',
    );
    gh.lazySingleton<String>(
      () => envConfigModule.dbName,
      instanceName: 'dbName',
    );
    gh.lazySingleton<int>(
      () => envConfigModule.dbVersion,
      instanceName: 'dbVersion',
    );
    gh.lazySingleton<bool>(
      () => envConfigModule.enableAnalytics,
      instanceName: 'enableAnalytics',
    );
    gh.lazySingleton<_i768.ProductLocalDataSource>(
      () => _i768.ProductLocalDataSource(gh<_i982.AppDatabase>()),
    );
    gh.lazySingleton<int>(
      () => envConfigModule.apiTimeout,
      instanceName: 'apiTimeout',
    );
    gh.lazySingleton<String>(
      () => envConfigModule.appName,
      instanceName: 'appName',
    );
    gh.lazySingleton<String>(
      () => envConfigModule.apiKey,
      instanceName: 'apiKey',
    );
    gh.lazySingleton<bool>(
      () => envConfigModule.debugMode,
      instanceName: 'debugMode',
    );
    gh.lazySingleton<_i963.ProductRepository>(
      () => _i764.ProductRepositoryImpl(gh<_i768.ProductLocalDataSource>()),
    );
    gh.lazySingleton<_i380.AddProduct>(
      () => _i380.AddProduct(gh<_i963.ProductRepository>()),
    );
    gh.lazySingleton<_i803.DeleteProduct>(
      () => _i803.DeleteProduct(gh<_i963.ProductRepository>()),
    );
    gh.lazySingleton<_i143.GetProducts>(
      () => _i143.GetProducts(gh<_i963.ProductRepository>()),
    );
    gh.lazySingleton<_i147.GetProductById>(
      () => _i147.GetProductById(gh<_i963.ProductRepository>()),
    );
    gh.lazySingleton<_i1073.UpdateProduct>(
      () => _i1073.UpdateProduct(gh<_i963.ProductRepository>()),
    );
    gh.factory<_i28.ProductBloc>(
      () => _i28.ProductBloc(
        gh<_i143.GetProducts>(),
        gh<_i380.AddProduct>(),
        gh<_i1073.UpdateProduct>(),
        gh<_i803.DeleteProduct>(),
      ),
    );
    return this;
  }
}

class _$DatabaseModule extends _i982.DatabaseModule {}

class _$LoggerModule extends _i594.LoggerModule {}

class _$EnvConfigModule extends _i373.EnvConfigModule {}
