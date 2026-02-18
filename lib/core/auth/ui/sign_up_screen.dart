import 'package:doc_doc/core/auth/logic/cubit/auth_cubit.dart';
import 'package:doc_doc/core/ui/dialogs/app_dialogs.dart';
import 'package:doc_doc/core/ui/loaders/overlay_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/spacing.dart';
import 'widgets/auth_screens_header.dart';
import 'widgets/sign_up/already_have_account_text.dart';
import 'widgets/sign_up/sign_up_form.dart';
import 'widgets/terms_and_conditions.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      verticalSpacing(50),
                      AuthScreensHeader(
                        title: 'auth.sign_up_title'.tr(),
                        subtitle: 'auth.sign_up_desc'.tr(),
                      ),
                      verticalSpacing(60),
                      const SignUpForm(),
                      verticalSpacing(50),
                      const TermsAndConditions(),
                      verticalSpacing(60),
                      const AlreadyHaveAccountText(),
                      verticalSpacing(50),
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
