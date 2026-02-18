import '../../../../themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../extensions/context_extensions.dart';
import '../../../../router/routes.dart';
import '../../../../themes/app_text_styles.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(final BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "auth.dont_have_account".tr(),
            style: AppTextStyles.font14Regular.copyWith(
              color: context.customColors.textSecondary,
            ),
          ),
          TextSpan(
            text: "auth.sign_up".tr(),
            style: AppTextStyles.font14SemiBold.copyWith(
              color: AppColors.primary300,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushReplacementNamed(Routes.signUpScreen);
              },
          ),
        ],
      ),
    );
  }
}
