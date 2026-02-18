import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/users/features/main_navigation/ui/main_scaffold.dart';
import '../../onboarding/ui/on_boarding_screen.dart';
import '../logic/cubit/auth_cubit.dart';

class UserAuthenticatedCheck extends StatelessWidget {
  const UserAuthenticatedCheck({super.key});

  @override
  Widget build(final BuildContext context) {
    final authState = context.watch<AuthCubit>().state;

    if (authState is AuthInitial || authState is AuthChecking) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (authState is AuthUnauthenticated ||
        authState is AuthFailure ||
        authState is AuthSessionExpired) {
      return const OnBoardingScreen();
    }

    return const MainScaffold();
  }
}
