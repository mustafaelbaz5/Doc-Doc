import '../../../../../../core/extensions/context_extensions.dart';
import '../../../../../../core/themes/app_text_styles.dart';
import '../../../../../../core/utils/spacing.dart';
import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({
    super.key,
    required this.title,
    required this.items,
    required this.selected,
    required this.onSelected,
  });

  final String title;
  final List<String> items;
  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: responsiveWidth(20),
        bottom: responsiveHeight(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.font16Bold),
          verticalSpacing(10),
          SizedBox(
            height: responsiveHeight(38),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, final _) => horizontalSpacing(8),
              itemBuilder: (final context, final index) {
                final item = items[index];
                final isSelected = item == selected;
                return GestureDetector(
                  onTap: () => onSelected(isSelected ? null : item),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: responsiveWidth(16),
                      vertical: responsiveHeight(8),
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? context.customColors.accentBlue
                          : context.customColors.divider.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(responsiveRadius(20)),
                      border: Border.all(
                        color: isSelected
                            ? context.customColors.accentBlue
                            : context.customColors.divider,
                      ),
                    ),
                    child: Text(
                      item,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: isSelected
                            ? Colors.white
                            : context.customColors.textSecondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
