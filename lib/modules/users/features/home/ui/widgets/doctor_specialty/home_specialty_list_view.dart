import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/data/models/specialization_data_model.dart';
import '../../../../../../../core/utils/spacing.dart';
import '../../../logic/cubit/home_cubit.dart';
import 'home_specialty_list_view_item.dart';

class HomeSpecialtyListView extends StatefulWidget {
  const HomeSpecialtyListView({super.key, required this.specializationList});
  final List<SpecializationDataModel> specializationList;

  @override
  State<HomeSpecialtyListView> createState() => _HomeSpecialtyListViewState();
}

class _HomeSpecialtyListViewState extends State<HomeSpecialtyListView> {
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
            child: HomeSpecialtyListViewItem(
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
