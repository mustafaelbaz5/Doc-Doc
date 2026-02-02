import 'widgets/auth_screens_header.dart';
import 'widgets/login/dont_have_account.dart';
import 'widgets/login/login_form.dart';
import 'widgets/terms_and_conditions.dart';
import '../../utils/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: responsiveWidth(32)),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                verticalSpacing(50),
                AuthScreensHeader(
                  title: 'auth.login_title'.tr(),
                  subtitle: "auth.login_desc".tr(),
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
      ),
    );
  }
}
