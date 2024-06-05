part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {}

class CategoryInitEvent extends CategoryEvent {
  final String slug;
  CategoryInitEvent({required this.slug});

  @override
  List<Object?> get props => [];
}

class CategoryLoadMore extends CategoryEvent {
  @override
  List<Object?> get props => [];
}
