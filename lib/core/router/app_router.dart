import 'package:flutter/material.dart';

import '../../modules/users/features/doctor_specialty/ui/doctor_specialty_screen.dart';
import '../../modules/users/features/main_navigation/ui/main_scaffold.dart';
import '../auth/ui/login_screen.dart';
import '../auth/ui/sign_up_screen.dart';
import '../onboarding/ui/on_boarding_screen.dart';
import 'routes.dart';

class AppRouter {
  Route<dynamic>? generateRoute(final RouteSettings settings) {
    // final Object? arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case Routes.mainScaffold:
        return MaterialPageRoute(builder: (_) => const MainScaffold());

      case Routes.doctorSpecialtyScreen:
        return MaterialPageRoute(builder: (_) => const DoctorSpecialtyScreen());

      default:
        return null;
    }
  }
}
