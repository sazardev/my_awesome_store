part of 'product_bloc.dart';

/// Eventos del Product BLoC
@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.loadProducts() = _LoadProducts;
  const factory ProductEvent.addProduct(Product product) = _AddProduct;
  const factory ProductEvent.updateProduct(Product product) = _UpdateProduct;
  const factory ProductEvent.deleteProduct(String id) = _DeleteProduct;
  const factory ProductEvent.refreshProducts() = _RefreshProducts;
}
