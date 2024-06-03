part of 'home_bloc.dart';

sealed class HomeState extends Equatable {}

final class HomeLoad extends HomeState {
  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  final bool loading, showCategory;
  final int? page;
  final List<CategoryModal>? categoryList, originalCateList;
  final List<ProductModal>? productList;

  HomeInitial(
      {this.page,
      this.loading = false,
      this.categoryList,
      this.originalCateList,
      this.productList,
      this.showCategory = false});

  HomeInitial copyWith(
          {bool? loading,
          List<CategoryModal>? categoryList,
          List<CategoryModal>? originalCateList,
          List<ProductModal>? productList,
          int? page,
          bool? showCategory}) =>
      HomeInitial(
        categoryList: categoryList ?? this.categoryList,
        loading: loading ?? this.loading,
        originalCateList: originalCateList ?? this.originalCateList,
        showCategory: showCategory ?? this.showCategory,
        page: page ?? this.page,
        productList: productList ?? this.productList,
      );

  @override
  List<Object?> get props =>
      [categoryList, loading, showCategory, originalCateList, page];
}

final class HomeError extends HomeState {
  @override
  List<Object?> get props => [];
}
