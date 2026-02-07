import 'package:flutter/material.dart';

import '../../../../../core/utils/spacing.dart';
import 'widgets/doctor_recommendation/home_recommendation_doctor.dart';
import 'widgets/doctor_specialty/home_doctor_specialty.dart';
import 'widgets/doctors_blue_container.dart';
import 'widgets/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeAppBar(),
            const DoctorsBlueContainer(),
            verticalSpacing(24),
            const HomeDoctorSpecialty(),
            verticalSpacing(24),
            // Give it fixed height or Expanded
            const Expanded(child: HomeRecommendationDoctor()),
          ],
        ),
      ),
    );
  }
}
