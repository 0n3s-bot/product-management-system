import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:pms/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:pms/bloc/home_bloc/home_screen.dart';
import 'package:pms/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:pms/bloc/login_bloc/login_screen.dart';
import 'package:pms/core_module.dart';
import 'package:pms/bloc/splash/bloc/splash_bloc.dart';
import 'package:pms/bloc/splash/splash_screen.dart';

class AppRouteName {
  static const String home = 'home';
  static const String splashScreen = 'Splash';
  static const String login = 'Login';
  static const String itemPreview = 'itemPreview';
  static const String gallery = 'galleryView';
}

class AppRouter {
  late GoRouter router;

  AppRouter() {
    router = GoRouter(
        routerNeglect: true,
        debugLogDiagnostics: true,
        initialLocation: '/',
        observers: [
          // RouteObserver()
        ],
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) {
              return MaterialPage(
                child: BlocProvider(
                  create: (context) => SplashBloc()..add(SplashInitEvent()),
                  child: const SplashScreen(),
                ),
              );
            },
          ),
          GoRoute(
            path: '/home',
            name: AppRouteName.home,
            builder: (context, state) {
              return
                  //  BlocProvider(
                  //   create: (context) => HomeBloc()..add(HomeInitEvent()),
                  //   child:
                  const HomeScreen()
                  // ,)
                  ;
            },
          ),
          GoRoute(
            path: '/login',
            name: AppRouteName.login,
            builder: (context, state) {
              return BlocProvider(
                create: (context) => LoginBloc(),
                child: const LoginScreen(),
              );
            },
          ),
          // GoRoute(
          //   path: '/gallery',
          //   name: AppRouteName.gallery,
          //   builder: (context, state) {
          //     Map detail = (state.extra ?? {}) as Map;
          //     return ImageViewScreen(
          //       images: detail['images'] ?? [],
          //       index: detail['index'] ?? 0,
          //     );
          //   },
          // ),

          //
        ]);
  }

  void clearAndNavigate({String? path}) {
    final goRoute = CoreModule.instance.appRouter.router;
    while (goRoute.canPop() == true) {
      // log("poped");
      goRoute.pop();
    }
    if (path != null) {
      goRoute.pushReplacement(path);
    }
  }

  // void clearAndNavigate(String path) {
  //   while (router.canPop() == true) {
  //     router.pop();
  //   }
  //   router.pushReplacement(path);
  // }
}
