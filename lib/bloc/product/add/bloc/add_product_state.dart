part of 'add_product_bloc.dart';

sealed class AddProductState extends Equatable {}

final class AddProductInitial extends AddProductState {
  final bool loading;
  final String? productId;
  final String? selectdCategory;

  AddProductInitial(
      {this.loading = false, this.selectdCategory, this.productId});
  @override
  List<Object?> get props => [loading];

  AddProductInitial copywith(
      {bool? loading, String? selectdCategory, String? productId}) {
    return AddProductInitial(
      loading: loading ?? this.loading,
      selectdCategory: selectdCategory ?? this.selectdCategory,
      productId: productId ?? this.productId,
    );
  }
}

final class AddProductEditState extends AddProductState {
  final ProductModal? product;

  AddProductEditState({this.product});
  @override
  List<Object?> get props => [];
}

final class AddProductSuccess extends AddProductState {
  final String message;

  AddProductSuccess({required this.message});
  @override
  List<Object?> get props => [];
}

final class AddProductLoad extends AddProductState {
  @override
  List<Object?> get props => [];
}

final class AddProductError extends AddProductState {
  final String message;

  AddProductError({required this.message});
  @override
  List<Object?> get props => [];
}
