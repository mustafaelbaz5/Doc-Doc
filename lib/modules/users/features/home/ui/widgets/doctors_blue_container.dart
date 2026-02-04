import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_colors.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/app_assets.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DoctorsBlueContainer extends StatelessWidget {
  const DoctorsBlueContainer({super.key});

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: responsiveHeight(195),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: responsiveHeight(165),
            padding: EdgeInsets.symmetric(
              horizontal: responsiveWidth(16),
              vertical: responsiveHeight(16),
            ),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(AppAssets.homeBlueContainerPng),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(responsiveRadius(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'home.blue_header'.tr(),
                  style: AppTextStyles.font18Bold.copyWith(
                    height: 1.5,
                    color: AppColors.grey0,
                  ),
                ),
                verticalSpacing(16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.grey0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          responsiveRadius(48),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: responsiveHeight(12),
                        horizontal: responsiveWidth(16),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'home.blue_header_button'.tr(),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.primary300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: context.isArabic ? responsiveRadius(16) : null,
            right: context.isArabic ? null : responsiveRadius(16),
            bottom: 0,
            child: Image.asset(
              AppAssets.homeFemaleDoctorPng,
              height: responsiveHeight(195),
            ),
          ),
        ],
      ),
    );
  }
}
