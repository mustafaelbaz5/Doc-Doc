import '../../../extensions/context_extensions.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_styles.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingImageAndText extends StatelessWidget {
  const OnBoardingImageAndText({super.key});

  @override
  Widget build(final BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(AppAssets.logoLowOpacitySvg),
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.customColors.background,
                context.customColors.background.withValues(alpha: .1),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.14, 0.4],
            ),
          ),
          child: Image.asset(AppAssets.onboardingDoctorPng),
        ),
        Positioned(
          bottom: responsiveHeight(20),
          left: 0,
          right: 0,
          child: Text(
            textAlign: TextAlign.center,
            'onBoarding.hero_title'.tr(),
            style: AppTextStyles.fontBold.copyWith(
              fontSize: responsiveFontSize(32),
              color: AppColors.primary300,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
