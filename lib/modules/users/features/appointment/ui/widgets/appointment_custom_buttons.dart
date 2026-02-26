import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

class AppointmentCustomButtons extends StatelessWidget {
  const AppointmentCustomButtons({
    super.key,
    required this.currentStep,
    required this.onNext,
    required this.onBack,
  });

  final int currentStep;
  final VoidCallback onNext;
  final VoidCallback onBack;
  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        responsiveWidth(16),
        responsiveHeight(12),
        responsiveWidth(16),
        responsiveHeight(20),
      ),
      child: Row(
        children: [
          if (currentStep > 0) ...[
            Container(
              padding: const EdgeInsets.only(
                left: 8,
                right: 2,
                top: 4,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                color: context.customColors.accentBlueSoft.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(responsiveRadius(12)),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            horizontalSpacing(12),
          ],
          Expanded(
            child: CustomTextButton(
              contentPadding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(0),
                vertical: responsiveHeight(0),
              ),
              text: currentStep == 2 ? 'Confirm' : 'Continue',
              onPressed: currentStep == 2 ? context.pop : onNext,
            ),
          ),
        ],
      ),
    );
  }
}
