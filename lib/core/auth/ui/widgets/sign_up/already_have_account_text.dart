import '../../../../extensions/context_extensions.dart';
import '../../../../router/routes.dart';
import '../../../../themes/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(final BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "auth.already_have_account".tr(),
            style: AppTextStyles.font14Regular.copyWith(
              color: context.customColors.textSecondary,
            ),
          ),
          TextSpan(
            text: "auth.login".tr(),
            style: AppTextStyles.font14SemiBold.copyWith(
              color: context.customColors.accentBlue,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushReplacementNamed(Routes.loginScreen);
              },
          ),
        ],
      ),
    );
  }
}
