import 'widgets/sign_up/already_have_account_text.dart';
import 'widgets/auth_screens_header.dart';
import 'widgets/sign_up/sign_up_form.dart';
import 'widgets/terms_and_conditions.dart';
import '../../utils/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: responsiveWidth(32)),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
      ),
    );
  }
}
