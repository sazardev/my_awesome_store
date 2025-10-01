part of 'product_bloc.dart';

/// Eventos del Product BLoC
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {
  const LoadProducts();
}

class LoadProductById extends ProductEvent {
  const LoadProductById(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}

class AddProduct extends ProductEvent {
  const AddProduct(this.product);
  final Product product;

  @override
  List<Object?> get props => [product];
}

class UpdateProduct extends ProductEvent {
  const UpdateProduct(this.product);
  final Product product;

  @override
  List<Object?> get props => [product];
}

class DeleteProduct extends ProductEvent {
  const DeleteProduct(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}

class RefreshProducts extends ProductEvent {
  const RefreshProducts();
}
