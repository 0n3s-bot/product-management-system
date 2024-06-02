part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {}

class LoginSubmmitEvent extends LoginEvent {
  final String? email, password;

  LoginSubmmitEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [];
}
