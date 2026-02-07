import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SpecialtyShimmerLoading extends StatelessWidget {
  const SpecialtyShimmerLoading({super.key});

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsiveWidth(16),
        vertical: responsiveHeight(8),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (final context, final index) {
          return Shimmer.fromColors(
            baseColor: context.customColors.border,
            highlightColor: context.customColors.background,
            child: Column(
              children: [
                // Circle avatar placeholder
                Container(
                  height: responsiveRadius(64), // same as radius * 2
                  width: responsiveRadius(64),
                  decoration: BoxDecoration(
                    color: context.customColors.border,
                    shape: BoxShape.circle,
                  ),
                ),
                verticalSpacing(8),
                // Text placeholder
                Container(
                  height: responsiveHeight(10), // short line for text
                  width: responsiveWidth(40),
                  decoration: BoxDecoration(
                    color: context.customColors.border,
                    borderRadius: BorderRadius.circular(6),
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
