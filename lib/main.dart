import 'package:flutter/material.dart';
import 'package:pms/app_cache/shared_pref/shared_pref.dart';
import 'package:pms/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CustomSharedPreference.init();
  runApp(const MyApp());
}
