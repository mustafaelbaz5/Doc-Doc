import 'package:doc_doc/core/themes/app_colors.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/modules/users/features/home/ui/home_screen.dart';
import 'package:doc_doc/modules/users/features/home/ui/widgets/doctor_list_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeRecommendationDoctor extends StatelessWidget {
  const HomeRecommendationDoctor({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "home.recommended_doctors".tr(),
              style: AppTextStyles.font18SemiBold,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: Text(
                "home.see_all".tr(),
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.primary300,
                ),
              ),
            ),
          ],
        ),
        verticalSpacing(16),
        Expanded(child: DoctorListView(doctors: dummyRecommendedDoctors)),
      ],
    );
  }
}
