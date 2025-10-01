import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';
import 'package:my_awesome_store/features/products/domain/usecases/add_product.dart';
import 'package:my_awesome_store/features/products/domain/usecases/delete_product.dart';
import 'package:my_awesome_store/features/products/domain/usecases/get_products.dart';
import 'package:my_awesome_store/features/products/domain/usecases/update_product.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

/// BLoC para gestión de productos
@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(
    this._getProducts,
    this._addProduct,
    this._updateProduct,
    this._deleteProduct,
  ) : super(const ProductState.initial()) {
    on<ProductEvent>(
      (event, emit) async {
        await event.when(
          loadProducts: () => _onLoadProducts(emit),
          addProduct: (product) => _onAddProduct(emit, product),
          updateProduct: (product) => _onUpdateProduct(emit, product),
          deleteProduct: (id) => _onDeleteProduct(emit, id),
          refreshProducts: () => _onRefreshProducts(emit),
        );
      },
    );
  }
  final GetProducts _getProducts;
  final AddProduct _addProduct;
  final UpdateProduct _updateProduct;
  final DeleteProduct _deleteProduct;

  /// Carga todos los productos
  Future<void> _onLoadProducts(Emitter<ProductState> emit) async {
    emit(const ProductState.loading());

    final result = await _getProducts();

    result.fold(
      (failure) => emit(ProductState.error(message: failure.message)),
      (products) => emit(ProductState.loaded(products: products)),
    );
  }

  /// Agrega un nuevo producto
  Future<void> _onAddProduct(
    Emitter<ProductState> emit,
    Product product,
  ) async {
    emit(const ProductState.loading());

    final result = await _addProduct(product);

    await result.fold(
      (failure) async => emit(ProductState.error(message: failure.message)),
      (_) async {
        // Recargar la lista de productos
        final productsResult = await _getProducts();
        productsResult.fold(
          (failure) => emit(ProductState.error(message: failure.message)),
          (products) => emit(ProductState.loaded(products: products)),
        );
      },
    );
  }

  /// Actualiza un producto existente
  Future<void> _onUpdateProduct(
    Emitter<ProductState> emit,
    Product product,
  ) async {
    emit(const ProductState.loading());

    final result = await _updateProduct(product);

    await result.fold(
      (failure) async => emit(ProductState.error(message: failure.message)),
      (_) async {
        // Recargar la lista de productos
        final productsResult = await _getProducts();
        productsResult.fold(
          (failure) => emit(ProductState.error(message: failure.message)),
          (products) => emit(ProductState.loaded(products: products)),
        );
      },
    );
  }

  /// Elimina un producto
  Future<void> _onDeleteProduct(
    Emitter<ProductState> emit,
    String id,
  ) async {
    emit(const ProductState.loading());

    final result = await _deleteProduct(id);

    await result.fold(
      (failure) async => emit(ProductState.error(message: failure.message)),
      (_) async {
        // Recargar la lista de productos
        final productsResult = await _getProducts();
        productsResult.fold(
          (failure) => emit(ProductState.error(message: failure.message)),
          (products) => emit(ProductState.loaded(products: products)),
        );
      },
    );
  }

  /// Refresca la lista de productos
  Future<void> _onRefreshProducts(Emitter<ProductState> emit) async {
    // No mostramos loading para el refresh (pull to refresh)
    final result = await _getProducts();

    result.fold(
      (failure) => emit(ProductState.error(message: failure.message)),
      (products) => emit(ProductState.loaded(products: products)),
    );
  }
}
