import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/utils/spacing.dart';

class DoctorsShimmerLoading extends StatelessWidget {
  const DoctorsShimmerLoading({super.key});

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (final context, final index) {
        return Container(
          margin: EdgeInsets.only(bottom: responsiveHeight(16)),
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: context.customColors.divider,
                highlightColor: Colors.white,
                child: Container(
                  width: responsiveWidth(110),
                  height: responsiveHeight(120),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12.0),
                    color: context.customColors.background,
                  ),
                ),
              ),
              horizontalSpacing(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: context.customColors.divider,
                      highlightColor: Colors.white,
                      child: Container(
                        height: responsiveHeight(18),
                        width: responsiveWidth(180),
                        decoration: BoxDecoration(
                          color: context.customColors.divider,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    verticalSpacing(12),
                    Shimmer.fromColors(
                      baseColor: context.customColors.divider,
                      highlightColor: Colors.white,
                      child: Container(
                        height: responsiveHeight(14),
                        width: responsiveWidth(160),
                        decoration: BoxDecoration(
                          color: context.customColors.divider,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    verticalSpacing(12),
                    Shimmer.fromColors(
                      baseColor: context.customColors.divider,
                      highlightColor: Colors.white,
                      child: Container(
                        height: responsiveHeight(14),
                        width: responsiveWidth(160),
                        decoration: BoxDecoration(
                          color: context.customColors.divider,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
