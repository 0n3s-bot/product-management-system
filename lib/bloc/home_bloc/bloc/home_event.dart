part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {}

class HomeInitEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeTriggerShowEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeLoadMoreEvent extends HomeEvent {
  final int page;
  HomeLoadMoreEvent({required this.page});
  @override
  List<Object?> get props => [];
}
