import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/spacing.dart';
import '../logic/cubit/home_cubit.dart';
import 'widgets/doctor_recommendation/home_recommendation_doctor.dart';
import 'widgets/doctor_specialty/home_doctor_specialty.dart';
import 'widgets/doctors_blue_container.dart';
import 'widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<HomeCubit>().getHomeSpecializations();
      }
    });
  }

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
            const Expanded(child: HomeRecommendationDoctor()),
          ],
        ),
      ),
    );
  }
}
