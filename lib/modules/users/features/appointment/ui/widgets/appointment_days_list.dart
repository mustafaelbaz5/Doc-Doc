import 'package:doc_doc/core/extensions/context_extensions.dart';
import 'package:doc_doc/core/utils/spacing.dart';
import 'package:doc_doc/modules/users/features/appointment/ui/widgets/appointment_day_card.dart';
import 'package:flutter/material.dart';

class AppointmentDaysList extends StatefulWidget {
  const AppointmentDaysList({
    super.key,
    required this.selectedDay,
    required this.onDaySelected,
  });

  final DateTime? selectedDay;
  final ValueChanged<DateTime> onDaySelected;

  @override
  State<AppointmentDaysList> createState() => _AppointmentDaysListState();
}

class _AppointmentDaysListState extends State<AppointmentDaysList> {
  final ScrollController _scrollController = ScrollController();

  List<DateTime> _generateDays() {
    final today = DateTime.now();
    return List.generate(14, (final i) => today.add(Duration(days: i)));
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - responsiveWidth(180),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + responsiveWidth(180),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final days = _generateDays();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsiveWidth(8)),
      child: Row(
        children: [
          // Left arrow
          GestureDetector(
            onTap: _scrollLeft,
            child: Icon(
              Icons.arrow_back_ios,
              size: responsiveWidth(24),
              color: context.customColors.textSecondary,
            ),
          ),
          horizontalSpacing(8),

          // Days list
          Expanded(
            child: SizedBox(
              height: responsiveHeight(70),
              child: ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: days.length,
                separatorBuilder: (_, final _) => horizontalSpacing(10),
                itemBuilder: (final context, final index) {
                  final day = days[index];
                  final isSelected =
                      widget.selectedDay != null &&
                      day.year == widget.selectedDay!.year &&
                      day.month == widget.selectedDay!.month &&
                      day.day == widget.selectedDay!.day;
                  return AppointmentDayCard(
                    day: day,
                    isSelected: isSelected,
                    onTap: () => widget.onDaySelected(day),
                  );
                },
              ),
            ),
          ),

          horizontalSpacing(8),
          // Right arrow
          GestureDetector(
            onTap: _scrollRight,
            child: Icon(
              Icons.arrow_forward_ios,
              size: responsiveWidth(24),
              color: context.customColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
