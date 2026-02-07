import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/modules/users/features/home/data/models/specializations_response_body.dart';
import 'package:doc_doc/modules/users/features/home/logic/cubit/home_cubit.dart';
import 'package:doc_doc/modules/users/features/home/ui/widgets/doctor_specialty/specialty_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialtyListView extends StatefulWidget {
  const SpecialtyListView({super.key, required this.specializationList});
  final List<SpecializationDataModel> specializationList;

  @override
  State<SpecialtyListView> createState() => _SpecialtyListViewState();
}

class _SpecialtyListViewState extends State<SpecialtyListView> {
  int selectedIndex = 0;
  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: responsiveHeight(100),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.specializationList.length,
        itemBuilder: (final context, final index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              context.read<HomeCubit>().getDoctorsBySpecialization(
                specializationId: widget.specializationList[index].id,
              );
            },
            child: SpecialtyListViewItem(
              itemIndex: index,
              selectedIndex: selectedIndex,
              specializationsData: widget.specializationList[index],
            ),
          );
        },
      ),
    );
  }
}
