import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/utils/spacing.dart';

class AllDoctorsShimmerLoading extends StatelessWidget {
  const AllDoctorsShimmerLoading({super.key});

  @override
  Widget build(final BuildContext context) {
    final baseColor = context.customColors.border.withValues(alpha: 0.3);
    final highlightColor = context.customColors.border.withValues(alpha: 0.1);

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpacing(16),

          /// 🔹 Doctors List
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
              itemCount: 6,
              separatorBuilder: (_, final _) => verticalSpacing(16),
              itemBuilder: (_, final _) => const _DoctorCardShimmer(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorCardShimmer extends StatelessWidget {
  const _DoctorCardShimmer();

  @override
  Widget build(final BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Avatar
        Container(
          width: responsiveWidth(80),
          height: responsiveHeight(80),
          decoration: BoxDecoration(
            color: context.customColors.background,
            borderRadius: BorderRadius.circular(responsiveRadius(12)),
          ),
        ),

        horizontalSpacing(16),

        /// Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Name
              Container(
                height: responsiveHeight(16),
                width: double.infinity,
                color: context.customColors.background,
              ),

              verticalSpacing(8),

              /// Degree + specialization
              Row(
                children: [
                  Container(
                    height: responsiveHeight(12),
                    width: responsiveWidth(80),
                    color: context.customColors.background,
                  ),
                  horizontalSpacing(8),
                  Container(
                    height: responsiveHeight(20),
                    width: responsiveWidth(60),
                    decoration: BoxDecoration(
                      color: context.customColors.background,
                      borderRadius: BorderRadius.circular(responsiveRadius(12)),
                    ),
                  ),
                ],
              ),

              verticalSpacing(12),

              /// Price + Time
              Row(
                children: [
                  Container(
                    height: responsiveHeight(12),
                    width: responsiveWidth(60),
                    color: context.customColors.background,
                  ),
                  horizontalSpacing(16),
                  Container(
                    height: responsiveHeight(12),
                    width: responsiveWidth(100),
                    color: context.customColors.background,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
