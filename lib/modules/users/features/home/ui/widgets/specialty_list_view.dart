import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/modules/users/features/home/data/models/specializations_response_body.dart';
import 'package:doc_doc/modules/users/features/home/ui/widgets/specialty_list_view_item.dart';
import 'package:flutter/material.dart';

class SpecialtyListView extends StatefulWidget {
  const SpecialtyListView({super.key});

  @override
  State<SpecialtyListView> createState() => _SpecialtyListViewState();
}

class _SpecialtyListViewState extends State<SpecialtyListView> {
  int selectedIndex = 0;
  @override
  Widget build(final BuildContext context) {
    final specializations = dummySpecializationsShort;

    return SizedBox(
      height: responsiveHeight(100),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: specializations.length,
        itemBuilder: (final context, final index) {
          final specialty = specializations[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: SpecialtyListViewItem(
              itemIndex: index,
              selectedIndex: selectedIndex,
              specializationsData: specialty,
            ),
          );
        },
      ),
    );
  }
}

final List<SpecializationDataModel> dummySpecializationsShort = [
  SpecializationDataModel(id: 1, name: "Cardiology", doctors: []),
  SpecializationDataModel(id: 2, name: "Dermatology", doctors: []),
  SpecializationDataModel(id: 3, name: "Neurology", doctors: []),
  SpecializationDataModel(id: 5, name: "Pediatrics", doctors: []),
  SpecializationDataModel(id: 6, name: "Gynecology", doctors: []),
];
