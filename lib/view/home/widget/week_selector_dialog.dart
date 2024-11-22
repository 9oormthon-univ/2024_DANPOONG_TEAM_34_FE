import 'package:flutter/material.dart';
import 'package:rebootOffice/model/home/week_state.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';

class WeekSelectorDialog extends StatelessWidget {
  final WeekState weekState;
  final Function(DateTime) onWeekSelected;

  const WeekSelectorDialog({
    super.key,
    required this.weekState,
    required this.onWeekSelected,
  });

  @override
  Widget build(BuildContext context) {
    final weeks = _calculateWeeksInMonth();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${weekState.currentTime.year}년 ${weekState.currentTime.month}월',
              style: FontSystem.KR16B,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ...weeks.map((week) => _buildWeekItem(context, week)),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _calculateWeeksInMonth() {
    final DateTime firstDay = DateTime(
      weekState.currentTime.year,
      weekState.currentTime.month,
      1,
    );
    final DateTime lastDay = DateTime(
      weekState.currentTime.year,
      weekState.currentTime.month + 1,
      0,
    );

    List<Map<String, dynamic>> weeks = [];
    DateTime currentDate = firstDay;
    int weekNumber = 1;

    while (currentDate.isBefore(lastDay) ||
        currentDate.isAtSameMomentAs(lastDay)) {
      final weekStart =
          currentDate.subtract(Duration(days: currentDate.weekday - 1));
      final weekEnd = weekStart.add(const Duration(days: 6));

      weeks.add({
        'weekNumber': weekNumber,
        'startDate': weekStart,
        'endDate': weekEnd,
        'isInWorkPeriod': _isWeekInWorkPeriod(weekStart, weekEnd),
      });

      currentDate = weekStart.add(const Duration(days: 7));
      weekNumber++;
    }

    return weeks;
  }

  bool _isWeekInWorkPeriod(DateTime weekStart, DateTime weekEnd) {
    final workStart = DateTime(
      weekState.workStartTime.year,
      weekState.workStartTime.month,
      weekState.workStartTime.day,
    );
    final workEnd = DateTime(
      weekState.workEndTime.year,
      weekState.workEndTime.month,
      weekState.workEndTime.day,
    );

    return !(weekEnd.isBefore(workStart) || weekStart.isAfter(workEnd));
  }

  Widget _buildWeekItem(BuildContext context, Map<String, dynamic> week) {
    final startDate = week['startDate'] as DateTime;
    final endDate = week['endDate'] as DateTime;
    final isInWorkPeriod = week['isInWorkPeriod'] as bool;

    return InkWell(
      onTap: () {
        onWeekSelected(startDate);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: ColorSystem.grey.shade200),
          ),
        ),
        child: Row(
          children: [
            Text(
              '${week['weekNumber']}주차',
              style: FontSystem.KR14R,
            ),
            const Spacer(),
            Text(
              '${startDate.day}일 ~ ${endDate.day}일',
              style: FontSystem.KR14R.copyWith(
                color: isInWorkPeriod
                    ? ColorSystem.blue.shade500
                    : ColorSystem.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
