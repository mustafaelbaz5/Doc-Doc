import 'package:cached_network_image/cached_network_image.dart';
import 'package:doc_doc/core/data/models/doctor_data_model.dart';
import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_colors.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/app_assets.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:flutter/material.dart';

class DoctorsDetailsHeader extends StatelessWidget {
  const DoctorsDetailsHeader({super.key, required this.doctor});

  final DoctorDataModel doctor;

  @override
  Widget build(final BuildContext context) {
    final isMale = doctor.gender.toLowerCase() == 'male';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            width: responsiveWidth(100),
            height: responsiveHeight(100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(responsiveRadius(12)),
              color: context.customColors.border.withValues(alpha: 0.3),
            ),
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
              imageUrl: doctor.photo,
              fit: BoxFit.cover,
              placeholder: (final context, final url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (final context, final url, final error) =>
                  Image.asset(
                    isMale
                        ? AppAssets.defaultMaleDoctorPng
                        : AppAssets.defaultFemaleDoctorPng,
                    fit: BoxFit.cover,
                  ),
            ),
          ),
          horizontalSpacing(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.name,
                style: AppTextStyles.font16SemiBold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpacing(14),
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
                      borderRadius: BorderRadius.circular(responsiveRadius(12)),
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
              verticalSpacing(4),
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
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.chat,
              size: responsiveFontSize(24),
              color: AppColors.primary300,
            ),
          ),
        ],
      ),
    );
  }
}
