import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/models/doctor_data_model.dart';
import '../../../../../../core/themes/app_colors.dart';
import '../../../../../../core/themes/app_text_styles.dart';
import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SpecialtyDoctorsListViewCard extends StatelessWidget {
  const SpecialtyDoctorsListViewCard({
    super.key,
    required this.doctor,
    this.onTap,
  });

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
          // Doctor Avatar
          Container(
            width: responsiveWidth(100),
            height: responsiveHeight(100),
            decoration: BoxDecoration(
              color: context.customColors.border,
              borderRadius: BorderRadius.circular(responsiveRadius(12)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(responsiveRadius(12)),
              child: CachedNetworkImage(
                imageUrl: doctor.photo,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 250),
                progressIndicatorBuilder:
                    (final context, final url, final progress) {
                      return Shimmer.fromColors(
                        baseColor: context.customColors.border,
                        highlightColor: context.customColors.background,
                        child: Container(
                          width: responsiveWidth(50),
                          height: responsiveHeight(50),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12.0),
                            color: context.customColors.background,
                          ),
                        ),
                      );
                    },
                errorWidget: (final context, final url, final error) =>
                    Image.asset(
                      isMale
                          ? AppAssets.defaultMaleDoctorPng
                          : AppAssets.defaultFemaleDoctorPng,
                      fit: BoxFit.cover,
                    ),
              ),
            ),
          ),
          horizontalSpacing(12),

          // Doctor Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  doctor.name,
                  style: AppTextStyles.font16SemiBold,
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
                        horizontal: responsiveWidth(6),
                        vertical: responsiveHeight(2),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary300.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          responsiveRadius(8),
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
                verticalSpacing(24),

                // Address
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: responsiveFontSize(14),
                    ),
                    horizontalSpacing(4),
                    Expanded(
                      child: Text(
                        doctor.city.name,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: context.customColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    horizontalSpacing(12),
                    Icon(
                      Icons.access_time_outlined,
                      size: responsiveFontSize(14),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
