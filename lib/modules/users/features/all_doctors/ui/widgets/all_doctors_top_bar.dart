import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/app_assets.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/core/widgets/custom_text_form_.dart';
import 'package:doc_doc/modules/users/features/all_doctors/ui/widgets/doctors_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllDoctorsTopBar extends StatelessWidget {
  const AllDoctorsTopBar({
    super.key,
    this.controller,
    this.onSearchChanged,
    this.specializations = const [],
    this.cities = const [],
    this.prices = const [],
    this.selectedSpecialization,
    this.selectedCity,
    this.selectedPrice,
    this.onSpecializationChanged,
    this.onCityChanged,
    this.onPriceChanged,
  });

  final TextEditingController? controller;
  final void Function(String)? onSearchChanged;

  final List<String> specializations;
  final List<String> cities;
  final List<String> prices;

  final String? selectedSpecialization;
  final String? selectedCity;
  final String? selectedPrice;

  final ValueChanged<String?>? onSpecializationChanged;
  final ValueChanged<String?>? onCityChanged;
  final ValueChanged<String?>? onPriceChanged;

  bool get _hasActiveFilter =>
      selectedSpecialization != null ||
      selectedCity != null ||
      selectedPrice != null;

  void _openFilterSheet(final BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(responsiveRadius(24)),
        ),
      ),
      builder: (final context) => DoctorsFilterBottomSheet(
        specializations: specializations,
        cities: cities,
        prices: prices,
        selectedSpecialization: selectedSpecialization,
        selectedCity: selectedCity,
        selectedPrice: selectedPrice,
        onSpecializationChanged: onSpecializationChanged,
        onCityChanged: onCityChanged,
        onPriceChanged: onPriceChanged,
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: controller,
              hintText: 'Search doctors...',
              onChanged: onSearchChanged,
              prefixIcon: Padding(
                padding: EdgeInsets.all(responsiveWidth(12)),
                child: SvgPicture.asset(
                  AppAssets.searchIconSvg,
                  width: responsiveWidth(20),
                  height: responsiveHeight(20),
                  colorFilter: ColorFilter.mode(
                    context.customColors.border,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              style: CustomTextFieldStyle.soft,
              hintStyle: AppTextStyles.font12Regular.copyWith(
                color: context.customColors.textSecondary.withValues(
                  alpha: 0.6,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(16),
                vertical: responsiveHeight(10),
              ),
              borderColor: context.customColors.divider,
              borderRadius: responsiveRadius(12),
              focusedBorderColor: context.customColors.divider,
              backgroundColor: context.customColors.divider.withValues(
                alpha: 0.3,
              ),
            ),
          ),
          horizontalSpacing(10),
          GestureDetector(
            onTap: () => _openFilterSheet(context),
            child: Container(
              padding: EdgeInsets.all(responsiveWidth(10)),
              decoration: BoxDecoration(
                color: _hasActiveFilter
                    ? context.customColors.accentBlue
                    : context.customColors.divider.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(responsiveRadius(12)),
                border: Border.all(color: context.customColors.divider),
              ),
              child: Icon(
                Icons.tune_rounded,
                color: _hasActiveFilter
                    ? Colors.white
                    : context.customColors.border,
                size: responsiveWidth(22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
