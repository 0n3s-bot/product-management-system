import 'package:flutter/material.dart';
import 'package:pms/app_cache/shared_pref/shared_pref.dart';
import 'package:pms/my_app.dart';
import 'package:pms/provider/app_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CustomSharedPreference.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppProvider()),
  ], child: const MyApp()));
}
