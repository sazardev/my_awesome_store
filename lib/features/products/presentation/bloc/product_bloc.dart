import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';
import 'package:my_awesome_store/features/products/domain/usecases/add_product.dart'
    as add_uc;
import 'package:my_awesome_store/features/products/domain/usecases/delete_product.dart'
    as delete_uc;
import 'package:my_awesome_store/features/products/domain/usecases/get_product_by_id.dart';
import 'package:my_awesome_store/features/products/domain/usecases/get_products.dart';
import 'package:my_awesome_store/features/products/domain/usecases/update_product.dart'
    as update_uc;

part 'product_event.dart';
part 'product_state.dart';

/// BLoC para gestión de productos
@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(
    this._getProductsUseCase,
    this._getProductByIdUseCase,
    this._addProductUseCase,
    this._updateProductUseCase,
    this._deleteProductUseCase,
  ) : super(const ProductInitial()) {
    on<LoadProducts>((event, emit) => _onLoadProducts(emit));
    on<LoadProductById>((event, emit) => _onLoadProductById(emit, event.id));
    on<AddProduct>((event, emit) => _onAddProduct(emit, event.product));
    on<UpdateProduct>((event, emit) => _onUpdateProduct(emit, event.product));
    on<DeleteProduct>((event, emit) => _onDeleteProduct(emit, event.id));
    on<RefreshProducts>((event, emit) => _onRefreshProducts(emit));
  }
  final GetProducts _getProductsUseCase;
  final GetProductById _getProductByIdUseCase;
  final add_uc.AddProductUseCase _addProductUseCase;
  final update_uc.UpdateProductUseCase _updateProductUseCase;
  final delete_uc.DeleteProductUseCase _deleteProductUseCase;

  /// Carga todos los productos
  Future<void> _onLoadProducts(Emitter<ProductState> emit) async {
    emit(const ProductLoading());

    final result = await _getProductsUseCase();

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products)),
    );
  }

  /// Carga un producto específico por ID
  Future<void> _onLoadProductById(
    Emitter<ProductState> emit,
    String id,
  ) async {
    emit(const ProductLoading());

    final result = await _getProductByIdUseCase(id);

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (product) => emit(ProductDetailLoaded(product)),
    );
  }

  /// Agrega un nuevo producto
  Future<void> _onAddProduct(
    Emitter<ProductState> emit,
    Product product,
  ) async {
    emit(const ProductLoading());

    final result = await _addProductUseCase(product);

    await result.fold(
      (failure) async => emit(ProductError(failure.message)),
      (_) async {
        // Recargar la lista de productos
        final productsResult = await _getProductsUseCase();
        productsResult.fold(
          (failure) => emit(ProductError(failure.message)),
          (products) => emit(ProductLoaded(products)),
        );
      },
    );
  }

  /// Actualiza un producto existente
  Future<void> _onUpdateProduct(
    Emitter<ProductState> emit,
    Product product,
  ) async {
    emit(const ProductLoading());

    final result = await _updateProductUseCase(product);

    await result.fold(
      (failure) async => emit(ProductError(failure.message)),
      (_) async {
        // Recargar la lista de productos
        final productsResult = await _getProductsUseCase();
        productsResult.fold(
          (failure) => emit(ProductError(failure.message)),
          (products) => emit(ProductLoaded(products)),
        );
      },
    );
  }

  /// Elimina un producto
  Future<void> _onDeleteProduct(
    Emitter<ProductState> emit,
    String id,
  ) async {
    emit(const ProductLoading());

    final result = await _deleteProductUseCase(id);

    await result.fold(
      (failure) async => emit(ProductError(failure.message)),
      (_) async {
        // Recargar la lista de productos
        final productsResult = await _getProductsUseCase();
        productsResult.fold(
          (failure) => emit(ProductError(failure.message)),
          (products) => emit(ProductLoaded(products)),
        );
      },
    );
  }

  /// Refresca la lista de productos
  Future<void> _onRefreshProducts(Emitter<ProductState> emit) async {
    // No mostramos loading para el refresh (pull to refresh)
    final result = await _getProductsUseCase();

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products)),
    );
  }
}
