import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pms/app_const/app_text.dart';
import 'package:pms/app_theme/app_theme.dart';
import 'package:pms/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:pms/core_module.dart';
import 'package:toastification/toastification.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc()..add(HomeInitEvent()),
            // child: const MyCartScreen(),
          ),
        ],
        child: MaterialApp.router(
            routerConfig: CoreModule.instance.appRouter.router,
            title: kAppName,
            theme: AppTheme.kLightTheme
            // home: const ,
            ),
      ),
    );
  }
}
