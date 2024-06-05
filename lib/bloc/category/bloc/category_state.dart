part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {}

final class CategoryLoad extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {
  final List<ProductModal>? productList;
  final bool loading, loadingMore;
  final int? pages;

  CategoryInitial(
      {this.productList,
      this.loading = false,
      this.loadingMore = false,
      this.pages});

  @override
  List<Object?> get props => [productList, loading, loadingMore, pages];

  CategoryInitial copyWith(
      {List<ProductModal>? productList,
      bool? loading,
      bool? loadingMore,
      int? pages}) {
    return CategoryInitial(
      loading: loading ?? this.loading,
      loadingMore: loadingMore ?? this.loadingMore,
      pages: pages ?? this.pages,
      productList: productList ?? this.productList,
    );
  }
}

final class CategoryError extends CategoryState {
  final String message;

  CategoryError({required this.message});
  @override
  List<Object?> get props => [];
}
