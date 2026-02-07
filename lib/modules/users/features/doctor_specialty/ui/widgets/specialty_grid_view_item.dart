import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/models/specialization_data_model.dart';
import '../../../../../../core/themes/app_text_styles.dart';
import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SpecialtyGridViewItem extends StatelessWidget {
  const SpecialtyGridViewItem({super.key, required this.specializationsData});

  final SpecializationDataModel specializationsData;
  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: responsiveRadius(32),
          backgroundColor: context.customColors.border.withValues(alpha: 0.3),
          child: SvgPicture.asset(
            AppAssets.generalSpecialtySvg,
            height: responsiveHeight(40),
            width: responsiveWidth(40),
          ),
        ),
        verticalSpacing(8),
        Text(
          specializationsData.name,
          textAlign: TextAlign.center,
          style: AppTextStyles.font12Regular.copyWith(
            color: context.customColors.textPrimary.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
