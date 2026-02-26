import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_colors.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:flutter/material.dart';

class AppointmentHeader extends StatelessWidget {
  const AppointmentHeader({super.key, required this.currentStep});

  final int currentStep;

  @override
  Widget build(final BuildContext context) {
    if (currentStep < 0 || currentStep > 2) {
      throw ArgumentError('currentStep must be between 0 and 2');
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Row(
        children: [
          _buildStep(context, 0, 'Date & Time'),
          _buildLine(context, currentStep > 1),
          _buildStep(context, 1, 'Payment'),
          _buildLine(context, currentStep > 2),
          _buildStep(context, 2, 'Summary'),
        ],
      ),
    );
  }

  Widget _buildStep(
    final BuildContext context,
    final int step,
    final String title,
  ) {
    final bool isActive = step == currentStep;
    final bool isCompleted = step < currentStep;

    Color circleColor;

    if (isActive) {
      circleColor = AppColors.primary300;
    } else if (isCompleted) {
      circleColor = AppColors.lightGreen;
    } else {
      circleColor = context.customColors.border;
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: circleColor,
          child: Text(
            '${step + 1}',
            style: AppTextStyles.font16SemiBold.copyWith(
              color: context.customColors.background,
            ),
          ),
        ),
        verticalSpacing(6),
        Text(
          title,
          style: AppTextStyles.font12Regular.copyWith(color: circleColor),
        ),
      ],
    );
  }

  Widget _buildLine(final BuildContext context, final bool isFinished) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 2,
        color: isFinished ? AppColors.lightGreen : context.customColors.divider,
      ),
    );
  }
}
