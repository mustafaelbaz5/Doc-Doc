import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:flutter/material.dart';

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
          'At least 1 lowercase letter',
          hasLowerCase,
          context,
        ),
        verticalSpacing(2),
        buildValidationRow(
          'At least 1 uppercase letter',
          hasUpperCase,
          context,
        ),
        verticalSpacing(2),
        buildValidationRow('At least 1 number', hasNumber, context),
        verticalSpacing(2),
        buildValidationRow(
          'At least 1 special character',
          hasSpecialCharacters,
          context,
        ),
        verticalSpacing(2),
        buildValidationRow('Minimum 8 characters', hasMinLength, context),
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
