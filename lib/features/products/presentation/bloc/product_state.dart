part of 'product_bloc.dart';

/// Estados del Product BLoC
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  const ProductLoaded(this.products);
  final List<Product> products;

  @override
  List<Object?> get props => [products];
}

class ProductDetailLoaded extends ProductState {
  const ProductDetailLoaded(this.product);
  final Product product;

  @override
  List<Object?> get props => [product];
}

class ProductError extends ProductState {
  const ProductError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
