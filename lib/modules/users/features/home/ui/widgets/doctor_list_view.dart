import 'package:doc_doc/modules/users/features/home/data/models/specializations_response_body.dart';
import 'package:doc_doc/modules/users/features/home/ui/widgets/doctor_recommendation_card.dart';
import 'package:flutter/material.dart';

class DoctorListView extends StatelessWidget {
  const DoctorListView({super.key, required this.doctors});

  final List<Doctor> doctors;

  @override
  Widget build(final BuildContext context) {
    if (doctors.isEmpty) {
      return const Center(child: Text("No recommended doctors yet"));
    }

    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (final context, final index) {
        final doctor = doctors[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DoctorRecommendationCard(doctor: doctor),
        );
      },
    );
  }
}
