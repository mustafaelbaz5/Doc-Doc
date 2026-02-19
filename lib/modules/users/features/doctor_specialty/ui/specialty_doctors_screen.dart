import 'package:flutter/material.dart';

import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import 'widgets/specialty_doctors_list_view.dart';

class SpecialtyDoctorsScreen extends StatelessWidget {
  const SpecialtyDoctorsScreen({
    super.key,
    required this.specialtyId,
    required this.specialtyName,
  });

  final int specialtyId;
  final String specialtyName;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            verticalSpacing(16),
            CustomAppBar(title: specialtyName),
            verticalSpacing(16),
            const Expanded(child: SpecialtyDoctorsListView()),
          ],
        ),
      ),
    );
  }
}
