part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {}

class RegisterSubmitEvent extends RegisterEvent {
  final String name, email, address, password;

  RegisterSubmitEvent(
      {required this.name,
      required this.email,
      required this.address,
      required this.password});

  @override
  List<Object?> get props => [];
}
