part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {}

class SearchInitEvent extends SearchEvent {
  final String item;

  SearchInitEvent({required this.item});
  @override
  List<Object?> get props => [];
}

class SearchApplyFilter extends SearchEvent {
  @override
  List<Object?> get props => [];
}
