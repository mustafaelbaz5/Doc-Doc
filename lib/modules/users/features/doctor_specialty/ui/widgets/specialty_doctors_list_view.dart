import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/data/models/doctor_data_model.dart';
import '../../../../../../core/utils/spacing.dart';
import '../../logic/cubit/specialty_cubit.dart';
import 'specialty_doctors_list_view_card.dart';
import 'specialty_doctors_shimmer.dart';

class SpecialtyDoctorsListView extends StatelessWidget {
  const SpecialtyDoctorsListView({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<SpecialtyCubit, SpecialtyState>(
      builder: (final context, final state) {
        if (state is SpecialtyLoading) {
          return const Center(child: SpecialtyDoctorsShimmer());
        } else if (state is SpecialtyFailed) {
          return Center(child: Text(state.error.messageKey));
        } else if (state is SpecialtyLoaded) {
          final List<DoctorDataModel> doctors = state.doctorsList!;
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: responsiveWidth(8)),
            itemCount: doctors.length,
            itemBuilder: (final context, final index) {
              final doctor = doctors[index];
              return Padding(
                padding: EdgeInsets.only(bottom: responsiveHeight(16)),
                child: SpecialtyDoctorsListViewCard(doctor: doctor),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
