import '../../../themes/app_text_styles.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingTopLogo extends StatelessWidget {
  const OnBoardingTopLogo({super.key});

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(AppAssets.logoSvg, height: 40, width: 40),
        horizontalSpacing(8),
        Text("DocDoc", style: AppTextStyles.fontBold.copyWith(fontSize: 24)),
      ],
    );
  }
}
