import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/core/widgets/custom_app_bar.dart';
import 'package:doc_doc/modules/users/features/home/ui/widgets/specialties_grid_view.dart';
import 'package:flutter/material.dart';

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
