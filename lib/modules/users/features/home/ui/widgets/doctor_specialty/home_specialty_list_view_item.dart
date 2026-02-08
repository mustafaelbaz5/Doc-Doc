import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/models/specialization_data_model.dart';
import '../../../../../../../core/themes/app_colors.dart';
import '../../../../../../../core/themes/app_text_styles.dart';
import '../../../../../../../core/utils/app_assets.dart';
import '../../../../../../../core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeSpecialtyListViewItem extends StatelessWidget {
  const HomeSpecialtyListViewItem({
    super.key,
    required this.itemIndex,
    required this.selectedIndex,
    required this.specializationsData,
  });
  final int itemIndex;
  final int selectedIndex;
  final SpecializationDataModel specializationsData;
  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: itemIndex == 0 ? 0 : responsiveWidth(16),
      ),
      child: Column(
        children: [
          itemIndex == selectedIndex
              ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary300,
                      width: responsiveWidth(1.5),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: responsiveRadius(28),
                    backgroundColor: context.customColors.background,
                    child: SvgPicture.asset(
                      AppAssets.generalSpecialtySvg,
                      height: responsiveHeight(40),
                      width: responsiveWidth(40),
                    ),
                  ),
                )
              : CircleAvatar(
                  radius: responsiveRadius(26),
                  backgroundColor: context.customColors.border.withValues(
                    alpha: 0.3,
                  ),
                  child: SvgPicture.asset(
                    AppAssets.generalSpecialtySvg,
                    height: responsiveHeight(38),
                    width: responsiveWidth(38),
                  ),
                ),
          verticalSpacing(8),
          Text(
            specializationsData.name,
            style: itemIndex == selectedIndex
                ? AppTextStyles.fontMedium.copyWith(
                    fontSize: responsiveFontSize(12),
                  )
                : AppTextStyles.fontMedium.copyWith(
                    fontSize: responsiveFontSize(10),
                    color: context.customColors.textSecondary,
                  ),
          ),
        ],
      ),
    );
  }
}
