import 'package:flutter/material.dart';
import 'package:rebootOffice/model/home/week_state.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/view/home/widget/report_button.dart';
import 'package:rebootOffice/view/home/widget/week_calendar.dart';

import 'week_selector.dart';

class WeekCalendarCard extends StatelessWidget {
  final WeekState weekState;
  final VoidCallback onWeekSelect;
  final VoidCallback onReportTap;

  const WeekCalendarCard({
    super.key,
    required this.weekState,
    required this.onWeekSelect,
    required this.onReportTap,
  });

  @override
  Widget build(BuildContext context) {
    final now = weekState.currentTime;
    final weekNumber = ((now.day - 1) ~/ 7);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: ColorSystem.grey.shade200, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WeekSelector(
            year: now.year,
            month: now.month,
            weekNumber: weekNumber,
            onTap: onWeekSelect,
          ),
          const SizedBox(height: 16),
          WeekCalendarView(weekState: weekState),
          const SizedBox(height: 16),
          ReportButton(onTap: onReportTap),
        ],
      ),
    );
  }
}
