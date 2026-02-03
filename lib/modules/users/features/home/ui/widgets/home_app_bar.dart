import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/app_assets.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: [
        const Column(
          children: [
            Text('Hi, Mustafa', style: AppTextStyles.font18Bold),
            Text('How are you?', style: AppTextStyles.font12Regular),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          radius: responsiveRadius(20),
          backgroundColor: context.customColors.divider.withValues(alpha: 0.5),
          child: SvgPicture.asset(AppAssets.notificationIconSvg),
        ),
      ],
    );
  }
}
