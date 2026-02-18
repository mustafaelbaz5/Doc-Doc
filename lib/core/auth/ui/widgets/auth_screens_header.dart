import 'package:flutter/material.dart';

import '../../../extensions/context_extensions.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../../../utils/spacing.dart';

class AuthScreensHeader extends StatelessWidget {
  const AuthScreensHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.fontBold.copyWith(
            fontSize: responsiveFontSize(24),
            color: AppColors.primary300,
          ),
        ),
        verticalSpacing(8),
        Text(
          subtitle,
          style: AppTextStyles.font14Regular.copyWith(
            height: 2,
            color: context.customColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
