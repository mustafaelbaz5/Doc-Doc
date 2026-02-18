import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../extensions/context_extensions.dart';
import '../../../../themes/app_text_styles.dart';
import '../../../../utils/spacing.dart';

class PasswordValidation extends StatelessWidget {
  const PasswordValidation({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        buildValidationRow(
          'auth.validation.password_validation_1'.tr(),
          hasLowerCase,
          context,
        ),
        verticalSpacing(2),
        buildValidationRow(
          'auth.validation.password_validation_2'.tr(),
          hasUpperCase,
          context,
        ),
        verticalSpacing(2),
        buildValidationRow(
          'auth.validation.password_validation_3'.tr(),
          hasNumber,
          context,
        ),
        verticalSpacing(2),
        buildValidationRow(
          'auth.validation.password_validation_4'.tr(),
          hasSpecialCharacters,
          context,
        ),
        verticalSpacing(2),
        buildValidationRow(
          'auth.validation.password_validation_5'.tr(),
          hasMinLength,
          context,
        ),
      ],
    );
  }

  Widget buildValidationRow(
    final String text,
    final bool hasValidated,
    final BuildContext context,
  ) {
    return Row(
      children: [
        CircleAvatar(
          radius: 2.5,
          backgroundColor: hasValidated
              ? context.customColors.textSecondary
              : context.customColors.textSecondary.withValues(alpha: 0.50),
        ),
        horizontalSpacing(6),
        Flexible(
          child: Text(
            text,
            style: AppTextStyles.font12Regular.copyWith(
              decoration: hasValidated ? TextDecoration.lineThrough : null,
              decorationColor: context.customColors.textSecondary.withValues(
                alpha: 0.50,
              ),
              decorationThickness: 2,
              color: hasValidated
                  ? context.customColors.textSecondary.withValues(alpha: 0.50)
                  : context.customColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
