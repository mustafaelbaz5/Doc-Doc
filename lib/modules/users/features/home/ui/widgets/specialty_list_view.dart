import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/modules/users/features/home/ui/home_screen.dart';
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
