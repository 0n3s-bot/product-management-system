import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pms/app_const/custom_textstyle.dart';
import 'package:pms/app_router/app_router.dart';
import 'package:pms/app_theme/app_colors.dart';
import 'package:pms/bloc/splash/bloc/splash_bloc.dart';
import 'package:pms/provider/app_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashGoToHome) {
          context.pushReplacementNamed(AppRouteName.home);

          Provider.of<AppProvider>(context, listen: false).init();
        }
        if (state is SplashGoToLogin) {
          context.pushReplacementNamed(AppRouteName.login);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.kPrimaryColor,
          body: Center(
            child: Text(
              "Product Management System",
              style: CustomTextStyle.splashTitleStyle,
            ),
          ),
        );
      },
    );
  }
}
