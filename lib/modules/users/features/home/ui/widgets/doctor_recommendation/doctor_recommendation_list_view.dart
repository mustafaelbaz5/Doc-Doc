import 'package:doc_doc/core/widgets/doctor_list_view_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/data/models/doctor_data_model.dart';

class DoctorRecommendationListView extends StatelessWidget {
  const DoctorRecommendationListView({super.key, required this.doctors});

  final List<DoctorDataModel> doctors;

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
          child: DoctorListViewCard(doctor: doctor),
        );
      },
    );
  }
}
