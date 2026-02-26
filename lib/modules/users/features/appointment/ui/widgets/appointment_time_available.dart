import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/modules/users/features/appointment/ui/widgets/appointment_time_card.dart';
import 'package:flutter/material.dart';

class AppointmentTimeAvailable extends StatefulWidget {
  const AppointmentTimeAvailable({super.key, required this.timeSlots});

  final List<String> timeSlots;

  @override
  State<AppointmentTimeAvailable> createState() =>
      _AppointmentTimeAvailableState();
}

class _AppointmentTimeAvailableState extends State<AppointmentTimeAvailable> {
  String? selectedTime;
  void onTimeSelected(final String time) => setState(() {
    selectedTime = time;
  });
  @override
  Widget build(final BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: responsiveWidth(10),
        mainAxisSpacing: responsiveHeight(10),
        childAspectRatio: 2.5,
      ),
      itemCount: widget.timeSlots.length,
      itemBuilder: (final context, final index) {
        final time = widget.timeSlots[index];
        final isSelected = time == selectedTime;
        return AppointmentTimeCard(
          time: time,
          isSelected: isSelected,
          onTap: () => onTimeSelected(time),
        );
      },
    );
  }
}
