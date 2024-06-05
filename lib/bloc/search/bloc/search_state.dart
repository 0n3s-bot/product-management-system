part of 'search_bloc.dart';

sealed class SearchState extends Equatable {}

final class SearchLoad extends SearchState {
  @override
  List<Object?> get props => [];
}

final class SearchInitial extends SearchState {
  final bool searching;
  final List<ProductModal>? productList;
  final int? total, shown;

  SearchInitial(
      {this.searching = false, this.productList, this.total, this.shown});
  @override
  List<Object?> get props => [searching, productList, total, shown];

  SearchInitial copyWith(
      {bool? searching,
      List<ProductModal>? productList,
      int? total,
      int? shown}) {
    return SearchInitial(
      searching: searching ?? this.searching,
      productList: productList ?? this.productList,
      total: total ?? this.total,
      shown: shown ?? this.shown,
    );
  }
}

final class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});
  @override
  List<Object?> get props => [];
}
