import 'package:flutter/material.dart';
import 'package:pms/app_cache/shared_pref/shared_pref.dart';
import 'package:pms/modal/register_modal.dart';

class AppProvider with ChangeNotifier {
  bool _loggedIn = false;
  RegisterModal _user = RegisterModal();

  bool get loggedIn => _loggedIn;
  RegisterModal get user => _user;

  init() {
    _loggedIn = CustomSharedPreference.getLoginStatus();
    if (_loggedIn) {
      _user = RegisterModal.fromJson(
          CustomSharedPreference.getLoggedUser() as Map<String, dynamic>);
    }
    //
  }
}
