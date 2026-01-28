import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/onboarding/ui/widgets/on_boarding_image_and_text.dart';
import 'package:doc_doc/core/onboarding/ui/widgets/on_boarding_top_bar.dart';
import 'package:doc_doc/core/onboarding/ui/widgets/on_boarding_top_logo.dart';
import 'package:doc_doc/core/router/routes.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/core/widgets/custom_text_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
            child: Column(
              children: [
                const OnBoardingTopBar(),
                const Center(child: OnBoardingTopLogo()),
                verticalSpacing(32),
                const OnBoardingImageAndText(),
                verticalSpacing(18),
                Text(
                  "onBoarding.hero_desc".tr(),
                  style: AppTextStyles.font14Regular.copyWith(
                    color: context.customColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                verticalSpacing(32),
                SizedBox(
                  width: responsiveWidth(320),
                  child: CustomTextButton(
                    borderRadius: responsiveRadius(16),
                    text: "onBoarding.get_started_button".tr(),
                    textStyle: AppTextStyles.font18SemiBold,
                    style: CustomButtonStyle.filled,
                    size: CustomButtonSize.large,
                    onPressed: () => context.pushNamed(Routes.loginScreen),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
