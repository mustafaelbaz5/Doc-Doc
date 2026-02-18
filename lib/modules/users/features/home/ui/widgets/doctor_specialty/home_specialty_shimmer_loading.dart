import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../../core/utils/spacing.dart';

class HomeSpecialtyShimmerLoading extends StatelessWidget {
  const HomeSpecialtyShimmerLoading({super.key});

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: responsiveHeight(100),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (final context, final index) {
          return Padding(
            padding: EdgeInsetsDirectional.only(
              start: index == 0 ? 0 : responsiveWidth(24),
            ),
            child: Column(
              children: [
                Shimmer.fromColors(
                  baseColor: context.customColors.border,
                  highlightColor: context.customColors.background,
                  child: CircleAvatar(
                    radius: responsiveRadius(28),
                    backgroundColor: Colors.white,
                  ),
                ),
                verticalSpacing(14),
                Shimmer.fromColors(
                  baseColor: context.customColors.border,
                  highlightColor: context.customColors.background,
                  child: Container(
                    height: responsiveHeight(14),
                    width: responsiveWidth(50),
                    decoration: BoxDecoration(
                      color: context.customColors.border,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
