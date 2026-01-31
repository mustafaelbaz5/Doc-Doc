import 'package:doc_doc/core/auth/ui/widgets/already_have_account_text.dart';
import 'package:doc_doc/core/auth/ui/widgets/auth_screens_header.dart';
import 'package:doc_doc/core/auth/ui/widgets/sign_up_form.dart';
import 'package:doc_doc/core/auth/ui/widgets/terms_and_conditions.dart';
import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/router/routes.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/core/widgets/custom_text_button.dart';
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
                verticalSpacing(40),
                CustomTextButton(
                  borderRadius: responsiveRadius(16),
                  text: 'auth.sign_up'.tr(),
                  textStyle: AppTextStyles.font18SemiBold,
                  style: CustomButtonStyle.filled,
                  size: CustomButtonSize.large,
                  onPressed: () =>
                      context.pushNamedAndRemoveAll(Routes.homeScreen),
                ),
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
