import 'package:doc_doc/core/auth/ui/widgets/auth_screens_header.dart';
import 'package:doc_doc/core/auth/ui/widgets/dont_have_account.dart';
import 'package:doc_doc/core/auth/ui/widgets/terms_and_conditions.dart';
import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/router/routes.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/core/widgets/custom_text_button.dart';
import 'package:doc_doc/core/widgets/custom_text_form_.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(32)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  verticalSpacing(50),
                  AuthScreensHeader(
                    title: 'auth.login_title'.tr(),
                    subtitle: "auth.login_desc".tr(),
                  ),
                  verticalSpacing(80),
                  CustomTextFormField(hintText: "auth.email".tr()),
                  verticalSpacing(16),
                  CustomTextFormField(
                    hintText: "auth.password".tr(),
                    isPassword: true,
                  ),
                  verticalSpacing(50),
                  CustomTextButton(
                    borderRadius: responsiveRadius(16),
                    text: "auth.login".tr(),
                    textStyle: AppTextStyles.font18SemiBold,
                    style: CustomButtonStyle.filled,
                    size: CustomButtonSize.large,
                    onPressed: () =>
                        context.pushNamedAndRemoveAll(Routes.homeScreen),
                  ),
                  verticalSpacing(80),
                  const TermsAndConditions(),
                  verticalSpacing(60),
                  const DontHaveAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
