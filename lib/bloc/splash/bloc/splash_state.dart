part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {}

class SplashLoad extends SplashState {
  @override
  List<Object?> get props => [];
}

final class SplashInitial extends SplashState {
  @override
  List<Object?> get props => [];
}

final class SplashGoToHome extends SplashState {
  @override
  List<Object?> get props => [];
}

final class SplashGoToLogin extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashError extends SplashState {
  @override
  List<Object?> get props => [];
}
