part of 'product_bloc.dart';

/// Estados del Product BLoC
@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;
  const factory ProductState.loaded({required List<Product> products}) =
      _Loaded;
  const factory ProductState.error({required String message}) = _Error;
}
