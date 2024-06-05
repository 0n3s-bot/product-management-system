part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {}

final class RegisterLoad extends RegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterInitial extends RegisterState {
  final bool loading;

  RegisterInitial({this.loading = false});

  RegisterInitial copyWith({bool? loading}) {
    return RegisterInitial(loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props => [loading];
}

final class RegisterSuccess extends RegisterState {
  final String message;

  RegisterSuccess({required this.message});
  @override
  List<Object?> get props => [];
}

final class RegisterError extends RegisterState {
  final String message;

  RegisterError({required this.message});
  @override
  List<Object?> get props => [];
}
