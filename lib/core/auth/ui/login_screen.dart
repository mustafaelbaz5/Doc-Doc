import 'package:doc_doc/core/auth/ui/widgets/auth_screens_header.dart';
import 'package:doc_doc/core/auth/ui/widgets/dont_have_account.dart';
import 'package:doc_doc/core/auth/ui/widgets/login_form.dart';
import 'package:doc_doc/core/auth/ui/widgets/terms_and_conditions.dart';
import 'package:doc_doc/core/utils/spacing.dart';
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
