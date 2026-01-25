// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_structure/core/router/routes.dart';
import 'package:flutter_structure/features/feature_ex/ui/app_screen.dart';

class AppRouter {
  Route<dynamic>? generateRoute(final RouteSettings settings) {
    // ignore: unused_local_variable
    final Object? arguments = settings.arguments;

    switch (settings.name) {
      case Routes.appScreen:
        return MaterialPageRoute(builder: (_) => const AppScreen());

      // case Routes.loginScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<LoginCubit>(),
      //       child: const LoginScreen(),
      //     ),
      //   );

      // case Routes.homeScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => const HomeScreen(),
      //   );

      default:
        return null;
    }
  }
}
