import 'package:doc_doc/modules/users/features/doctor_details/logic/cubit/doctor_details_cubit.dart';
import 'package:doc_doc/modules/users/features/doctor_details/ui/doctor_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/users/features/all_doctors/logic/all_doctors/all_doctors_cubit.dart';
import '../../modules/users/features/all_doctors/logic/filter_data/filter_data_cubit.dart';
import '../../modules/users/features/all_doctors/ui/all_doctors_screen.dart';
import '../../modules/users/features/doctor_specialty/logic/cubit/specialty_cubit.dart';
import '../../modules/users/features/doctor_specialty/ui/doctor_specialty_screen.dart';
import '../../modules/users/features/doctor_specialty/ui/specialty_doctors_screen.dart';
import '../../modules/users/features/main_navigation/ui/main_scaffold.dart';
import '../../modules/users/features/onboarding/ui/on_boarding_screen.dart';
import '../auth/ui/login_screen.dart';
import '../auth/ui/sign_up_screen.dart';
import '../di/dependency_injection.dart';
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
      case Routes.allDoctorsScreen:
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

      case Routes.doctorDetailsScreen:
        return MaterialPageRoute(
          builder: (final context) => BlocProvider(
            create: (final context) =>
                getIt<DoctorDetailsCubit>()
                  ..showDoctorDetails(args?['doctorId'] as int),
            child: const DoctorDetailsScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
