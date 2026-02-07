import 'package:doc_doc/core/di/dependency_injection.dart';
import 'package:doc_doc/modules/users/features/doctor_specialty/logic/cubit/specialty_cubit.dart';
import 'package:doc_doc/modules/users/features/doctor_specialty/ui/specialty_doctors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (final context) =>
                getIt<SpecialtyCubit>()..getAllSpecializations(),
            child: const DoctorSpecialtyScreen(),
          ),
        );
      case Routes.specialtyDoctorsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (final context) => getIt<SpecialtyCubit>(),
            child: const SpecialtyDoctorsScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
