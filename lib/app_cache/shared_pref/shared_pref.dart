import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

const _isLoggedIn = "loggedIn";

class CustomSharedPreference {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

// // // ------------>>>>>>>>>>>>>>> GET Values <<<<<<<<<<------------------- // // //

  static bool getLoginStatus() {
    bool? str = _preferences?.getBool(_isLoggedIn) ?? false;

    return str;
  }

// // // // ------------>>>>>>>>>>>>>>> set Values <<<<<<<<<<------------------- // // //

  static Future setLoginStatus(bool value) async =>
      await _preferences?.setBool(_isLoggedIn, value);

// // // ------------>>>>>>>>>>>>>>> Clear Data <<<<<<<<<<------------------- // // //

  static Future<void> signOut({bool show = true}) async {
    List rem = [_isLoggedIn];

    for (var element in rem) {
      await _preferences!.remove(element);
      log("Removed $element");
    }
  }
}
