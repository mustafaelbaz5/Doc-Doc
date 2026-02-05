import 'package:doc_doc/modules/users/features/home/ui/doctor_specialty_screen.dart';
import 'package:doc_doc/modules/users/features/main_navigation/cubit/bottom_nav_cubit.dart';
import 'package:doc_doc/modules/users/features/main_navigation/ui/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/logic/cubit/auth_cubit.dart';
import '../auth/ui/login_screen.dart';
import '../auth/ui/sign_up_screen.dart';
import '../di/dependency_injection.dart';
import '../onboarding/ui/on_boarding_screen.dart';
import 'routes.dart';

class AppRouter {
  Route<dynamic>? generateRoute(final RouteSettings settings) {
    // ignore: unused_local_variable
    final Object? arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (final context) => getIt<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (final context) => getIt<AuthCubit>(),
            child: const SignUpScreen(),
          ),
        );

      case Routes.mainScaffold:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (final context) => BottomNavCubit(),
            child: const MainScaffold(),
          ),
        );

      case Routes.doctorSpecialtyScreen:
        return MaterialPageRoute(builder: (_) => const DoctorSpecialtyScreen());
      default:
        return null;
    }
  }
}
