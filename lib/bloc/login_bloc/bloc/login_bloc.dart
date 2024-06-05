import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/app_cache/shared_pref/shared_pref.dart';
import 'package:pms/utills/password_encoder.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmmitEvent>(
        (event, emit) => _onLogin(event, emit, state as LoginInitial));
  }

  void _onLogin(LoginSubmmitEvent event, Emitter<LoginState> emit,
      LoginInitial currState) async {
    List userlist = CustomSharedPreference.getUsersList();
    log(userlist.toString());
    bool contains = false;

    Map user = {};
    for (var usr in userlist) {
      if (usr['email'] == event.email) {
        log(usr['email']);

        user = usr;
        contains = true;
        break;
      }
    }

    // String pswd = encodePasswordWithMD5(event.password ?? "");

    if (contains) {
      bool validate = verifyPassword(event.password ?? "", user["password"]);
      if (validate) {
        await CustomSharedPreference.setLoginStatus(true);
        await CustomSharedPreference.setloggedUser(json.encode(user));
        emit(LoginSuccess(messgae: "login Successful."));
      } else {
        emit(LoginError(messgae: "wrong Password"));
        emit(currState.copyWith(loading: false));
      }

      //
    } else {
      emit(LoginError(messgae: "User not registered."));
      log("User not registered.");
      emit(currState.copyWith(loading: false));
    }
  }
}
