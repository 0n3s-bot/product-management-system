import 'dart:convert';
import 'dart:developer';

import 'package:pms/modal/register_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _isLoggedIn = "loggedIn";
const _users = "users";
const _user = "user";

class CustomSharedPreference {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

// // // ------------>>>>>>>>>>>>>>> GET Values <<<<<<<<<<------------------- // // //

  static bool getLoginStatus() {
    bool? str = _preferences?.getBool(_isLoggedIn) ?? false;

    return str;
  }

  static List getUsersList() {
    String? str = _preferences?.getString(_users) ?? '[]';
    List usrlist = json.decode(str);

    return usrlist;
  }

  static Map getLoggedUser() {
    String? str = _preferences?.getString(_users) ?? '{}';
    Map usrlist = json.decode(str);

    return usrlist;
  }
// // // // ------------>>>>>>>>>>>>>>> set Values <<<<<<<<<<------------------- // // //

  static Future setLoginStatus(bool value) async =>
      await _preferences?.setBool(_isLoggedIn, value);

  static Future setUsers(String value) async =>
      await _preferences?.setString(_users, value);

  static Future setloggedUser(String value) async =>
      await _preferences?.setString(_user, value);

// // // ------------>>>>>>>>>>>>>>> Clear Data <<<<<<<<<<------------------- // // //

  static Future<void> signOut({bool show = true}) async {
    List rem = [
      _isLoggedIn,
      _user,
    ];

    for (var element in rem) {
      await _preferences!.remove(element);
      log("Removed $element");
    }
  }
}
