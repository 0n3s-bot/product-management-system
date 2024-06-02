part of 'login_bloc.dart';

sealed class LoginState extends Equatable {}

final class LoginLoad extends LoginState {
  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {
  final bool loading;

  LoginInitial({this.loading = false});
  @override
  List<Object?> get props => [loading];

  LoginInitial copyWith({bool? loading}) =>
      LoginInitial(loading: loading ?? this.loading);
}

final class LoginError extends LoginState {
  final String messgae;

  LoginError({required this.messgae});
  @override
  List<Object?> get props => [];
}

// final class LoginNotApproved extends LoginState {
//   final String messgae;

//   LoginNotApproved({required this.messgae});
//   @override
//   List<Object?> get props => [];
// }

final class LoginSuccess extends LoginState {
  final String messgae;

  LoginSuccess({required this.messgae});
  @override
  List<Object?> get props => [];
}
