import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/app_cache/shared_pref/shared_pref.dart';
import 'package:pms/modal/register_modal.dart';
import 'package:pms/utills/password_encoder.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitEvent>(
        (event, emit) => _onregister(event, emit, state as RegisterInitial));
  }

  void _onregister(RegisterSubmitEvent event, Emitter<RegisterState> emit,
      RegisterInitial currState) async {
    // emit(currState.copyWith(loading: true));

    List userlist = CustomSharedPreference.getUsersList();
    log("user list : \n $userlist");
    Map<String, dynamic> map = {
      "name": event.name,
      "address": event.address,
      "email": event.email,
      "password": encodePasswordWithMD5(event.password),
      "date": DateTime.now().toString()
    };

    bool contains = false;
    for (var usr in userlist) {
      if (usr['email'] == event.email) {
        log(usr['email']);
        contains = true;
        break;
      }
    }
    //
    emit(currState.copyWith(loading: true));
    if (contains) {
      emit(RegisterError(message: "user already exists!"));
      log("user Exists");

      emit(currState.copyWith(loading: false));
    } else {
      userlist.add(map);
      await CustomSharedPreference.setUsers(json.encode(userlist));
      emit(RegisterSuccess(message: "User registered successfully."));
      log("user added");
      emit(currState.copyWith(loading: false));
    }
    log(contains.toString());
    log(map.toString());
    //
  }

  String encodePassword(String password) {
    var bytes = utf8.encode(password);
    var base64Str = base64.encode(bytes);
    return base64Str;
  }

  // String encodePasswordWithMD5(String password) {
  //   var bytes = utf8.encode(password); // Convert password to bytes
  //   var digest = md5.convert(bytes); // Perform MD5 hash
  //   return digest.toString(); // Convert hash to string
  // }

  // bool verifyPassword(String inputPassword, String storedHash) {
  //   String inputHash = encodePasswordWithMD5(inputPassword);
  //   return inputHash == storedHash;
  // }
}
