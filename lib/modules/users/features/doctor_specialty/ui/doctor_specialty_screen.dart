import 'package:flutter/material.dart';

import '../../../../../core/utils/spacing.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import 'widgets/specialties_grid_view.dart';

class DoctorSpecialtyScreen extends StatelessWidget {
  const DoctorSpecialtyScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            verticalSpacing(16),
            const CustomAppBar(title: 'Doctor Specialty'),
            verticalSpacing(16),
            const SpecialtiesGridView(),
          ],
        ),
      ),
    );
  }
}
