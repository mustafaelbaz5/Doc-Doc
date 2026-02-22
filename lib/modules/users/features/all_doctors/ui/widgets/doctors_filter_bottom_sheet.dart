import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/themes/app_text_styles.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/modules/users/features/all_doctors/ui/widgets/filter_section.dart';
import 'package:flutter/material.dart';

class DoctorsFilterBottomSheet extends StatefulWidget {
  const DoctorsFilterBottomSheet({
    super.key,
    required this.specializations,
    required this.cities,
    required this.prices,
    this.selectedSpecialization,
    this.selectedCity,
    this.selectedPrice,
    this.onApply,
  });

  final List<String> specializations;
  final List<String> cities;
  final List<String> prices;

  final String? selectedSpecialization;
  final String? selectedCity;
  final String? selectedPrice;

  final void Function(String? specialization, String? city, String? price)?
  onApply;

  @override
  State<DoctorsFilterBottomSheet> createState() =>
      _DoctorsFilterBottomSheetState();
}

class _DoctorsFilterBottomSheetState extends State<DoctorsFilterBottomSheet> {
  String? _selectedSpecialization;
  String? _selectedCity;
  String? _selectedPrice;

  @override
  void initState() {
    super.initState();
    _selectedSpecialization = widget.selectedSpecialization;
    _selectedCity = widget.selectedCity;
    _selectedPrice = widget.selectedPrice;
  }

  void _applyFilters() {
    widget.onApply?.call(
      _selectedSpecialization,
      _selectedCity,
      _selectedPrice,
    );
    Navigator.pop(context);
  }

  void _clearFilters() {
    setState(() {
      _selectedSpecialization = null;
      _selectedCity = null;
      _selectedPrice = null;
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              margin: EdgeInsets.only(top: responsiveHeight(12)),
              width: responsiveWidth(40),
              height: responsiveHeight(4),
              decoration: BoxDecoration(
                color: context.customColors.divider,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsiveWidth(20),
              vertical: responsiveHeight(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filter', style: AppTextStyles.font18Bold),
                GestureDetector(
                  onTap: _clearFilters,
                  child: Text(
                    'Clear all',
                    style: AppTextStyles.font14Regular.copyWith(
                      color: context.customColors.accentBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),

          FilterSection(
            title: 'Specialization',
            items: widget.specializations,
            selected: _selectedSpecialization,
            onSelected: (final val) =>
                setState(() => _selectedSpecialization = val),
          ),

          FilterSection(
            title: 'City',
            items: widget.cities,
            selected: _selectedCity,
            onSelected: (final val) => setState(() => _selectedCity = val),
          ),

          FilterSection(
            title: 'Price',
            items: widget.prices,
            selected: _selectedPrice,
            onSelected: (final val) => setState(() => _selectedPrice = val),
          ),

          verticalSpacing(16),

          // Apply button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(20)),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.customColors.accentBlue,
                  padding: EdgeInsets.symmetric(vertical: responsiveHeight(14)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(responsiveRadius(12)),
                  ),
                ),
                child: Text(
                  'Apply Filters',
                  style: AppTextStyles.font16Bold.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          verticalSpacing(24),
        ],
      ),
    );
  }
}
