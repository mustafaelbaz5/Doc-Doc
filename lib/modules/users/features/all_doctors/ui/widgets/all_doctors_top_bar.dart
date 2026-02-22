import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_colors.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/app_assets.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/core/widgets/custom_text_form_.dart';
import 'package:doc_doc/modules/users/features/all_doctors/logic/cubit/filter_data/filter_data_cubit.dart';
import 'package:doc_doc/modules/users/features/all_doctors/ui/widgets/doctors_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllDoctorsTopBar extends StatelessWidget {
  const AllDoctorsTopBar({
    super.key,
    this.controller,
    this.onSearchChanged,
    this.selectedSpecialization,
    this.selectedCity,
    this.selectedPrice,
    this.onApply,
  });

  final TextEditingController? controller;
  final void Function(String)? onSearchChanged;

  final String? selectedSpecialization;
  final String? selectedCity;
  final String? selectedPrice;

  final void Function(String? specialization, String? city, String? price)?
      onApply;

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
      builder: (final _) => BlocProvider.value(
        value: context.read<FilterDataCubit>(),
        child: BlocBuilder<FilterDataCubit, FilterDataState>(
          builder: (final context, final state) {
            final specializations = state is FilterDataLoaded
                ? state.specializations.map((final e) => e.name).toList()
                : <String>[];
            final cities = state is FilterDataLoaded
                ? state.cities.map((final e) => e.name).toList()
                : <String>[];
            const prices = <String>['< 100', '100 - 200', '200 - 300', '> 300'];
            return DoctorsFilterBottomSheet(
              specializations: specializations,
              cities: cities,
              prices: prices,
              selectedSpecialization: selectedSpecialization,
              selectedCity: selectedCity,
              selectedPrice: selectedPrice,
              onApply: onApply,
            );
          },
        ),
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
            onTap: () {
              _openFilterSheet(context);
            },
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
                    ? AppColors.grey0
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
