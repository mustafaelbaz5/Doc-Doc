import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/models/doctor_data_model.dart';
import 'package:doc_doc/core/themes/app_colors.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/app_assets.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:flutter/material.dart';

class DoctorRecommendationCard extends StatelessWidget {
  const DoctorRecommendationCard({super.key, required this.doctor, this.onTap});

  final DoctorDataModel doctor;
  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) {
    final isMale = doctor.gender.toLowerCase() == 'male';

    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor avatar
          Container(
            width: responsiveWidth(80),
            height: responsiveHeight(80),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(responsiveRadius(12)),
              color: context.customColors.border,
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              isMale
                  ? AppAssets.defaultMaleDoctorPng
                  : AppAssets.defaultFemaleDoctorPng,
              fit: BoxFit.cover,
            ),
          ),

          horizontalSpacing(16),

          // Doctor information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  doctor.name,
                  style: AppTextStyles.font18SemiBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                verticalSpacing(4),

                // Degree & Specialty
                Row(
                  children: [
                    Text(
                      doctor.degree,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: context.customColors.textSecondary,
                      ),
                    ),
                    horizontalSpacing(8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveWidth(8),
                        vertical: responsiveHeight(2),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary300.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          responsiveRadius(12),
                        ),
                      ),
                      child: Text(
                        doctor.specialization.name,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.primary300,
                        ),
                      ),
                    ),
                  ],
                ),

                verticalSpacing(8),

                // Fees & Availability
                Row(
                  children: [
                    Icon(
                      Icons.monetization_on_outlined,
                      size: 16,
                      color: context.customColors.textSecondary,
                    ),
                    horizontalSpacing(4),
                    Text(
                      "${doctor.appointPrice} EGP",
                      style: AppTextStyles.font12Regular,
                    ),
                    horizontalSpacing(16),
                    Icon(
                      Icons.access_time_outlined,
                      size: 16,
                      color: context.customColors.textSecondary,
                    ),
                    horizontalSpacing(4),
                    Text(
                      "${doctor.startTime.replaceAll(':00', '')} - ${doctor.endTime.replaceAll(':00', '')}",
                      style: AppTextStyles.font12Regular.copyWith(
                        color: context.customColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                verticalSpacing(10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
