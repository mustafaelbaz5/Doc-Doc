import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(final BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "auth.terms_and_conditions_1".tr(),
            style: AppTextStyles.font14Regular.copyWith(
              color: context.customColors.textSecondary,
            ),
          ),
          TextSpan(
            text: "auth.terms_and_conditions_2".tr(),
            style: AppTextStyles.font14SemiBold.copyWith(
              color: context.customColors.accentBlue,
            ),
          ),
          TextSpan(
            text: "auth.terms_and_conditions_3".tr(),
            style: AppTextStyles.font14Regular.copyWith(
              color: context.customColors.textSecondary,
            ),
          ),
          TextSpan(
            text: "auth.terms_and_conditions_4".tr(),
            style: AppTextStyles.font14SemiBold.copyWith(
              color: context.customColors.accentBlue,
            ),
          ),
        ],
      ),
    );
  }
}
