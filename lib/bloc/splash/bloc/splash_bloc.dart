import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/app_cache/shared_pref/shared_pref.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashInitEvent>(
        (event, emit) => _onEvent(event, emit, state as SplashInitial));
  }

  void _onEvent(SplashInitEvent event, Emitter<SplashState> emit,
      SplashInitial currState) async {
    await Future.delayed(const Duration(seconds: 4)).whenComplete(() async {
      bool loggedin = CustomSharedPreference.getLoginStatus();

      if (loggedin) {
        emit(SplashGoToHome());
      } else {
        emit(SplashGoToLogin());
      }
    });
  }
}
