import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_colors.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:flutter/material.dart';

class AppointmentDayCard extends StatelessWidget {
  const AppointmentDayCard({
    super.key,
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  final DateTime day;
  final bool isSelected;
  final VoidCallback onTap;

  static const _dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: responsiveWidth(56),
        decoration: BoxDecoration(
          color: isSelected
              ? context.customColors.accentBlue
              : context.customColors.divider.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(responsiveRadius(12)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _dayNames[day.weekday - 1],
              style: isSelected
                  ? AppTextStyles.font14Bold.copyWith(
                      color: AppColors.grey0,
                      height: 1,
                    )
                  : AppTextStyles.font12Regular.copyWith(
                      color: context.customColors.textSecondary,
                    ),
            ),
            verticalSpacing(8),
            Text(
              '${day.day < 10 ? '0' : ''}${day.day}',
              style: isSelected
                  ? AppTextStyles.font14Bold.copyWith(
                      color: AppColors.grey0,
                      height: 1.8,
                    )
                  : AppTextStyles.font12Regular.copyWith(
                      color: context.customColors.textSecondary,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
