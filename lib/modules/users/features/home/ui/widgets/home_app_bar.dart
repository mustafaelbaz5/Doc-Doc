import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/themes/app_text_styles.dart';
import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/utils/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              "${'home.top_bar_title'.tr()} Mustafa",
              style: AppTextStyles.font18Bold,
            ),
            Text(
              'home.top_bar_subtitle'.tr(),
              style: AppTextStyles.font12Regular,
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: responsiveRadius(20),
            backgroundColor: context.customColors.divider.withValues(
              alpha: 0.5,
            ),
            child: SvgPicture.asset(
              AppAssets.notificationIconSvg,
              colorFilter: const ColorFilter.mode(
                AppColors.primary300,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
