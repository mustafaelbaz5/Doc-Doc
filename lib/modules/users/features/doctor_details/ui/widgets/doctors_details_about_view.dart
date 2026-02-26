import 'package:doc_doc/core/data/models/doctor_data_model.dart';
import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:flutter/material.dart';

class DoctorsDetailsAboutView extends StatelessWidget {
  const DoctorsDetailsAboutView({super.key, required this.doctor});
  final DoctorDataModel doctor;

  @override
  Widget build(final BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(responsiveWidth(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About me', style: AppTextStyles.font16SemiBold),
          verticalSpacing(8),
          Text(
            doctor.description.isNotEmpty
                ? doctor.description
                : 'No description available',
            style: AppTextStyles.font14Regular.copyWith(
              color: context.customColors.textSecondary,
            ),
          ),
          verticalSpacing(24),
          Text('Working Time', style: AppTextStyles.font16SemiBold),
          verticalSpacing(8),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 18,
                color: context.customColors.textSecondary,
              ),
              horizontalSpacing(6),
              Text(
                "${_formatTime(doctor.startTime)} - ${_formatTime(doctor.endTime)}",
                style: AppTextStyles.font14Regular.copyWith(
                  color: context.customColors.textSecondary,
                ),
              ),
            ],
          ),
          verticalSpacing(24),
          Text('Consultation Fee', style: AppTextStyles.font16SemiBold),
          verticalSpacing(8),
          Row(
            children: [
              Icon(
                Icons.monetization_on_outlined,
                size: 18,
                color: context.customColors.textSecondary,
              ),
              horizontalSpacing(6),
              Text(
                "${doctor.appointPrice} EGP",
                style: AppTextStyles.font14Regular.copyWith(
                  color: context.customColors.textSecondary,
                ),
              ),
            ],
          ),

          verticalSpacing(24),

          Text('Location', style: AppTextStyles.font16SemiBold),
          verticalSpacing(8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: responsiveFontSize(18),
                color: context.customColors.textSecondary,
              ),
              horizontalSpacing(6),
              Expanded(
                child: Text(
                  "${doctor.city.name}, ${doctor.city.governrate.name}\n${doctor.address}",
                  style: AppTextStyles.font14Regular.copyWith(
                    color: context.customColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          verticalSpacing(24),
          Text('Contact', style: AppTextStyles.font16SemiBold),
          verticalSpacing(8),
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 18,
                color: context.customColors.textSecondary,
              ),
              horizontalSpacing(6),
              Text(
                doctor.phone,
                style: AppTextStyles.font14Regular.copyWith(
                  color: context.customColors.textSecondary,
                ),
              ),
            ],
          ),
          verticalSpacing(8),
          Row(
            children: [
              Icon(
                Icons.email_outlined,
                size: responsiveFontSize(18),
                color: context.customColors.textSecondary,
              ),
              horizontalSpacing(6),
              Expanded(
                child: Text(doctor.email, style: AppTextStyles.font14Regular),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(final String time) {
    return time.replaceAll(':00', '');
  }
}
