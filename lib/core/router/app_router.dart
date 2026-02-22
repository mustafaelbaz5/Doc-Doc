import 'package:doc_doc/modules/users/features/all_doctors/logic/cubit/all_doctors/all_doctors_cubit.dart';
import 'package:doc_doc/modules/users/features/all_doctors/logic/cubit/filter_data/filter_data_cubit.dart';
import 'package:doc_doc/modules/users/features/all_doctors/ui/all_doctors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/users/features/doctor_specialty/logic/cubit/specialty_cubit.dart';
import '../../modules/users/features/doctor_specialty/ui/doctor_specialty_screen.dart';
import '../../modules/users/features/doctor_specialty/ui/specialty_doctors_screen.dart';
import '../../modules/users/features/main_navigation/ui/main_scaffold.dart';
import '../auth/ui/login_screen.dart';
import '../auth/ui/sign_up_screen.dart';
import '../di/dependency_injection.dart';
import '../onboarding/ui/on_boarding_screen.dart';
import 'routes.dart';

class AppRouter {
  Route<dynamic>? generateRoute(final RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;

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
            create: (final context) =>
                getIt<SpecialtyCubit>()
                  ..getSpecialtyById(specialtyId: args?['specialtyId'] as int),
            child: SpecialtyDoctorsScreen(
              specialtyId: args?['specialtyId'] as int,
              specialtyName: args?['specialtyName'] as String,
            ),
          ),
        );
      case Routes.recommendationDoctorScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (final context) =>
                    getIt<AllDoctorsCubit>()..getAllDoctors(),
              ),
              BlocProvider(
                create: (final context) =>
                    getIt<FilterDataCubit>()..loadFilterData(),
              ),
            ],
            child: const AllDoctorsScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
