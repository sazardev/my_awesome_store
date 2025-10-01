// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductEvent()';
}


}

/// @nodoc
class $ProductEventCopyWith<$Res>  {
$ProductEventCopyWith(ProductEvent _, $Res Function(ProductEvent) __);
}


/// Adds pattern-matching-related methods to [ProductEvent].
extension ProductEventPatterns on ProductEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadProducts value)?  loadProducts,TResult Function( _AddProduct value)?  addProduct,TResult Function( _UpdateProduct value)?  updateProduct,TResult Function( _DeleteProduct value)?  deleteProduct,TResult Function( _RefreshProducts value)?  refreshProducts,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadProducts() when loadProducts != null:
return loadProducts(_that);case _AddProduct() when addProduct != null:
return addProduct(_that);case _UpdateProduct() when updateProduct != null:
return updateProduct(_that);case _DeleteProduct() when deleteProduct != null:
return deleteProduct(_that);case _RefreshProducts() when refreshProducts != null:
return refreshProducts(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadProducts value)  loadProducts,required TResult Function( _AddProduct value)  addProduct,required TResult Function( _UpdateProduct value)  updateProduct,required TResult Function( _DeleteProduct value)  deleteProduct,required TResult Function( _RefreshProducts value)  refreshProducts,}){
final _that = this;
switch (_that) {
case _LoadProducts():
return loadProducts(_that);case _AddProduct():
return addProduct(_that);case _UpdateProduct():
return updateProduct(_that);case _DeleteProduct():
return deleteProduct(_that);case _RefreshProducts():
return refreshProducts(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadProducts value)?  loadProducts,TResult? Function( _AddProduct value)?  addProduct,TResult? Function( _UpdateProduct value)?  updateProduct,TResult? Function( _DeleteProduct value)?  deleteProduct,TResult? Function( _RefreshProducts value)?  refreshProducts,}){
final _that = this;
switch (_that) {
case _LoadProducts() when loadProducts != null:
return loadProducts(_that);case _AddProduct() when addProduct != null:
return addProduct(_that);case _UpdateProduct() when updateProduct != null:
return updateProduct(_that);case _DeleteProduct() when deleteProduct != null:
return deleteProduct(_that);case _RefreshProducts() when refreshProducts != null:
return refreshProducts(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadProducts,TResult Function( Product product)?  addProduct,TResult Function( Product product)?  updateProduct,TResult Function( String id)?  deleteProduct,TResult Function()?  refreshProducts,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadProducts() when loadProducts != null:
return loadProducts();case _AddProduct() when addProduct != null:
return addProduct(_that.product);case _UpdateProduct() when updateProduct != null:
return updateProduct(_that.product);case _DeleteProduct() when deleteProduct != null:
return deleteProduct(_that.id);case _RefreshProducts() when refreshProducts != null:
return refreshProducts();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadProducts,required TResult Function( Product product)  addProduct,required TResult Function( Product product)  updateProduct,required TResult Function( String id)  deleteProduct,required TResult Function()  refreshProducts,}) {final _that = this;
switch (_that) {
case _LoadProducts():
return loadProducts();case _AddProduct():
return addProduct(_that.product);case _UpdateProduct():
return updateProduct(_that.product);case _DeleteProduct():
return deleteProduct(_that.id);case _RefreshProducts():
return refreshProducts();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadProducts,TResult? Function( Product product)?  addProduct,TResult? Function( Product product)?  updateProduct,TResult? Function( String id)?  deleteProduct,TResult? Function()?  refreshProducts,}) {final _that = this;
switch (_that) {
case _LoadProducts() when loadProducts != null:
return loadProducts();case _AddProduct() when addProduct != null:
return addProduct(_that.product);case _UpdateProduct() when updateProduct != null:
return updateProduct(_that.product);case _DeleteProduct() when deleteProduct != null:
return deleteProduct(_that.id);case _RefreshProducts() when refreshProducts != null:
return refreshProducts();case _:
  return null;

}
}

}

/// @nodoc


class _LoadProducts implements ProductEvent {
  const _LoadProducts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadProducts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductEvent.loadProducts()';
}


}




/// @nodoc


class _AddProduct implements ProductEvent {
  const _AddProduct(this.product);
  

 final  Product product;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddProductCopyWith<_AddProduct> get copyWith => __$AddProductCopyWithImpl<_AddProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddProduct&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'ProductEvent.addProduct(product: $product)';
}


}

/// @nodoc
abstract mixin class _$AddProductCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory _$AddProductCopyWith(_AddProduct value, $Res Function(_AddProduct) _then) = __$AddProductCopyWithImpl;
@useResult
$Res call({
 Product product
});


$ProductCopyWith<$Res> get product;

}
/// @nodoc
class __$AddProductCopyWithImpl<$Res>
    implements _$AddProductCopyWith<$Res> {
  __$AddProductCopyWithImpl(this._self, this._then);

  final _AddProduct _self;
  final $Res Function(_AddProduct) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(_AddProduct(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,
  ));
}

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductCopyWith<$Res> get product {
  
  return $ProductCopyWith<$Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}

/// @nodoc


class _UpdateProduct implements ProductEvent {
  const _UpdateProduct(this.product);
  

 final  Product product;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateProductCopyWith<_UpdateProduct> get copyWith => __$UpdateProductCopyWithImpl<_UpdateProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateProduct&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'ProductEvent.updateProduct(product: $product)';
}


}

/// @nodoc
abstract mixin class _$UpdateProductCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory _$UpdateProductCopyWith(_UpdateProduct value, $Res Function(_UpdateProduct) _then) = __$UpdateProductCopyWithImpl;
@useResult
$Res call({
 Product product
});


$ProductCopyWith<$Res> get product;

}
/// @nodoc
class __$UpdateProductCopyWithImpl<$Res>
    implements _$UpdateProductCopyWith<$Res> {
  __$UpdateProductCopyWithImpl(this._self, this._then);

  final _UpdateProduct _self;
  final $Res Function(_UpdateProduct) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(_UpdateProduct(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,
  ));
}

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductCopyWith<$Res> get product {
  
  return $ProductCopyWith<$Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}

/// @nodoc


class _DeleteProduct implements ProductEvent {
  const _DeleteProduct(this.id);
  

 final  String id;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteProductCopyWith<_DeleteProduct> get copyWith => __$DeleteProductCopyWithImpl<_DeleteProduct>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteProduct&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ProductEvent.deleteProduct(id: $id)';
}


}

/// @nodoc
abstract mixin class _$DeleteProductCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory _$DeleteProductCopyWith(_DeleteProduct value, $Res Function(_DeleteProduct) _then) = __$DeleteProductCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$DeleteProductCopyWithImpl<$Res>
    implements _$DeleteProductCopyWith<$Res> {
  __$DeleteProductCopyWithImpl(this._self, this._then);

  final _DeleteProduct _self;
  final $Res Function(_DeleteProduct) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_DeleteProduct(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RefreshProducts implements ProductEvent {
  const _RefreshProducts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshProducts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductEvent.refreshProducts()';
}


}




/// @nodoc
mixin _$ProductState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState()';
}


}

/// @nodoc
class $ProductStateCopyWith<$Res>  {
$ProductStateCopyWith(ProductState _, $Res Function(ProductState) __);
}


/// Adds pattern-matching-related methods to [ProductState].
extension ProductStatePatterns on ProductState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Product> products)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.products);case _Error() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Product> products)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.products);case _Error():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Product> products)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.products);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ProductState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState.initial()';
}


}




/// @nodoc


class _Loading implements ProductState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState.loading()';
}


}




/// @nodoc


class _Loaded implements ProductState {
  const _Loaded({required final  List<Product> products}): _products = products;
  

 final  List<Product> _products;
 List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}


/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._products, _products));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products));

@override
String toString() {
  return 'ProductState.loaded(products: $products)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Product> products
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,}) {
  return _then(_Loaded(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,
  ));
}


}

/// @nodoc


class _Error implements ProductState {
  const _Error({required this.message});
  

 final  String message;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProductState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
