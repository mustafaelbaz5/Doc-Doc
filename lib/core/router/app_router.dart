import 'package:doc_doc/core/auth/ui/login_screen.dart';
import 'package:doc_doc/core/auth/ui/sign_up_screen.dart';
import 'package:doc_doc/core/onboarding/ui/on_boarding_screen.dart';
import 'package:doc_doc/core/router/routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route<dynamic>? generateRoute(final RouteSettings settings) {
    // ignore: unused_local_variable
    final Object? arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      // case Routes.loginScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => getIt<LoginCubit>(),
      //       child: const LoginScreen(),
      //     ),
      //   );


      default:
        return null;
    }
  }
}
