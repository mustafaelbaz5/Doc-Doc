import 'package:doc_doc/core/onboarding/ui/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/users/features/main_navigation/ui/main_scaffold.dart';
import '../logic/cubit/auth_cubit.dart';

class UserAuthenticatedCheck extends StatelessWidget {
  const UserAuthenticatedCheck({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (final prev, final curr) => curr is! AuthLoading,
      builder: (final context, final state) {
        if (state is AuthAuthenticated) {
          return const MainScaffold();
        }

        if (state is AuthUnauthenticated) {
          return const OnBoardingScreen();
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
