import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pms/app_router/app_router.dart';
import 'package:pms/bloc/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashGoToHome) {
          context.pushNamed(AppRouteName.home);
        }
        if (state is SplashGoToLogin) {
          context.pushNamed(AppRouteName.login);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Text("Product Management System"),
          ),
        );
      },
    );
  }
}
