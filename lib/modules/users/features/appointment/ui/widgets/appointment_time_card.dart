import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_colors.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:flutter/material.dart';

class AppointmentTimeCard extends StatelessWidget {
  const AppointmentTimeCard({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? context.customColors.accentBlue
              : context.customColors.divider.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(responsiveRadius(12)),
        ),
        alignment: Alignment.center,
        child: Text(
          time,
          style: isSelected
              ? AppTextStyles.font14Bold.copyWith(color: AppColors.grey0)
              : AppTextStyles.font12Regular.copyWith(
                  color: context.customColors.textSecondary,
                ),
        ),
      ),
    );
  }
}
