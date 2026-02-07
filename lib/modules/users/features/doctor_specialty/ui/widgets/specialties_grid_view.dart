import 'package:doc_doc/core/models/specialization_data_model.dart';
import 'package:doc_doc/modules/users/features/doctor_specialty/ui/widgets/specialty_grid_view_item.dart';
import 'package:flutter/material.dart';

class SpecialtiesGridView extends StatefulWidget {
  const SpecialtiesGridView({super.key, this.onItemTap});

  final Function(int)? onItemTap;

  @override
  State<SpecialtiesGridView> createState() => _SpecialtiesGridViewState();
}

class _SpecialtiesGridViewState extends State<SpecialtiesGridView> {
  int selectedIndex = -1;

  final List<SpecializationDataModel> specializations = [
    SpecializationDataModel(id: 1, name: 'Cardiology', doctors: []),
    SpecializationDataModel(id: 2, name: 'Dermatology', doctors: []),
    SpecializationDataModel(id: 3, name: 'Neurology', doctors: []),
    SpecializationDataModel(id: 4, name: 'Pediatrics', doctors: []),
    SpecializationDataModel(id: 5, name: 'Psychiatry', doctors: []),
    SpecializationDataModel(id: 6, name: 'Radiology', doctors: []),
    SpecializationDataModel(id: 6, name: 'Radiology', doctors: []),
  ];

  @override
  Widget build(final BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: GridView.builder(
          itemCount: specializations.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 items per row
            crossAxisSpacing: 24, // horizontal spacing
            mainAxisSpacing: 16, // vertical spacing
            childAspectRatio: .8, // width/height ratio
          ),
          itemBuilder: (final context, final index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: SpecialtyGridViewItem(
                specializationsData: specializations[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
