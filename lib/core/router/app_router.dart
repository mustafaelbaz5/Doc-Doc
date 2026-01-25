// ignore_for_file: always_specify_types

import 'package:doc_doc/core/router/routes.dart';
import 'package:doc_doc/features/feature_ex/ui/app_screen.dart';
import 'package:flutter/material.dart';

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
