import 'package:doc_doc/core/models/specialization_data_model.dart';
import 'package:doc_doc/modules/users/features/doctor_specialty/logic/cubit/specialty_cubit.dart';
import 'package:doc_doc/modules/users/features/doctor_specialty/ui/widgets/specialty_grid_view_item.dart';
import 'package:doc_doc/modules/users/features/doctor_specialty/ui/widgets/specialty_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialtiesGridView extends StatelessWidget {
  const SpecialtiesGridView({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<SpecialtyCubit, SpecialtyState>(
      builder: (final context, final state) {
        if (state is SpecialtyLoading) {
          return const SpecialtyShimmerLoading();
        } else if (state is SpecialtyFailed) {
          return Center(child: Text(state.error.messageKey));
        } else if (state is AllSpecializationLoaded) {
          final List<SpecializationDataModel> specializations =
              state.specializations!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: GridView.builder(
              shrinkWrap: true, // important for vertical scroll
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: specializations.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 items per row
                crossAxisSpacing: 28, // horizontal spacing
                mainAxisSpacing: 16, // vertical spacing
                childAspectRatio: .75, // width/height ratio
              ),
              itemBuilder: (final context, final index) {
                return GestureDetector(
                  onTap: () {
                    context.read<SpecialtyCubit>().getSpecialtyById(
                      specialtyId: specializations[index].id,
                    );
                  },
                  child: SpecialtyGridViewItem(
                    specializationsData: specializations[index],
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
