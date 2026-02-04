import 'package:doc_doc/core/themes/app_colors.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/modules/users/features/home/ui/widgets/specialty_list_view.dart';
import 'package:flutter/material.dart';

class HomeDoctorSpecialty extends StatelessWidget {
  const HomeDoctorSpecialty({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Doctor Specialty", style: AppTextStyles.font18SemiBold),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: Text(
                "See All",
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.primary300,
                ),
              ),
            ),
          ],
        ),
        verticalSpacing(16),
        const SpecialtyListView(),
      ],
    );
  }
}
