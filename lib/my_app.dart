import 'package:flutter/material.dart';
import 'package:pms/app_theme/app_theme.dart';
import 'package:pms/core_module.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: CoreModule.instance.appRouter.router,
        title: 'Flutter Demo',
        theme: AppTheme.kLightTheme
        // home: const ,
        );
  }
}
