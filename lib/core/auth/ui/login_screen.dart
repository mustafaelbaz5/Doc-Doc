import '../logic/cubit/auth_cubit.dart';
import '../../ui/dialogs/app_dialogs.dart';
import '../../ui/loaders/overlay_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/spacing.dart';
import 'widgets/auth_screens_header.dart';
import 'widgets/login/dont_have_account.dart';
import 'widgets/login/login_form.dart';
import 'widgets/terms_and_conditions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (final context, final state) {
            if (state is AuthAuthenticated) {
              Navigator.of(context).popUntil((final route) => route.isFirst);
            } else if (state is AuthFailure) {
              AppDialogs.showError(
                context,
                message: state.error.messageKey.tr(),
              );
            }
          },
          builder: (final context, final state) {
            return OverlayLoader(
              isLoading: state is AuthChecking,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: responsiveWidth(32)),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      verticalSpacing(50),
                      AuthScreensHeader(
                        title: 'auth.login_title'.tr(),
                        subtitle: 'auth.login_desc'.tr(),
                      ),
                      verticalSpacing(80),
                      const LoginForm(),
                      verticalSpacing(80),
                      const TermsAndConditions(),
                      verticalSpacing(60),
                      const DontHaveAccount(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
