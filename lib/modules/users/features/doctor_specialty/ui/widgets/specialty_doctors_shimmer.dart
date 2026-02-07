import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SpecialtyDoctorsShimmer extends StatelessWidget {
  const SpecialtyDoctorsShimmer({super.key});

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(8)),
      itemCount: 10,
      itemBuilder: (final context, final index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar shimmer
            Shimmer.fromColors(
              baseColor: context.customColors.border,
              highlightColor: context.customColors.background,
              child: Container(
                width: responsiveWidth(100),
                height: responsiveHeight(100),
                decoration: BoxDecoration(
                  color: context.customColors.border,
                  borderRadius: BorderRadius.circular(responsiveRadius(12)),
                ),
              ),
            ),
            horizontalSpacing(12),

            // Info shimmer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Shimmer.fromColors(
                    baseColor: context.customColors.border,
                    highlightColor: context.customColors.background,
                    child: Container(
                      width: responsiveWidth(150),
                      height: responsiveHeight(20),
                      decoration: BoxDecoration(
                        color: context.customColors.border,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  verticalSpacing(6),

                  // Degree & Specialty
                  Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: context.customColors.border,
                        highlightColor: context.customColors.background,
                        child: Container(
                          width: responsiveWidth(80),
                          height: responsiveHeight(16),
                          decoration: BoxDecoration(
                            color: context.customColors.border,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      horizontalSpacing(8),
                      Shimmer.fromColors(
                        baseColor: context.customColors.border,
                        highlightColor: context.customColors.background,
                        child: Container(
                          width: responsiveWidth(80),
                          height: responsiveHeight(16),
                          decoration: BoxDecoration(
                            color: context.customColors.border,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpacing(24),

                  // Address & Time
                  Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: context.customColors.border,
                        highlightColor: context.customColors.background,
                        child: Container(
                          width: responsiveWidth(120),
                          height: responsiveHeight(16),
                          decoration: BoxDecoration(
                            color: context.customColors.border,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      horizontalSpacing(12),
                      Shimmer.fromColors(
                        baseColor: context.customColors.border,
                        highlightColor: context.customColors.background,
                        child: Container(
                          width: responsiveWidth(80),
                          height: responsiveHeight(16),
                          decoration: BoxDecoration(
                            color: context.customColors.border,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
