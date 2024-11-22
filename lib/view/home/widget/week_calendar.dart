import 'package:flutter/material.dart';
import 'package:rebootOffice/model/home/week_state.dart';
import 'package:rebootOffice/view/home/widget/day_item.dart';

class WeekCalendarView extends StatelessWidget {
  final WeekState weekState;

  const WeekCalendarView({
    Key? key,
    required this.weekState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final days = _generateDays();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days
          .map((day) => DayItem(
                weekday: day['weekday'] as String,
                date: day['date'] as String,
                isSelected: day['isSelected'] as bool,
              ))
          .toList(),
    );
  }

  List<Map<String, dynamic>> _generateDays() {
    final now = weekState.currentTime;
    final weekStart = now.subtract(Duration(days: now.weekday - 1));

    return List.generate(7, (index) {
      final date = weekStart.add(Duration(days: index));
      return {
        'weekday': _getWeekdayString(date.weekday),
        'date': date.day.toString(),
        'isSelected': _isDateInWorkPeriod(
            date, weekState.workStartTime, weekState.workEndTime),
      };
    });
  }

// _getWeekdayString 및 _isDateInWorkPeriod 메서드는 그대로 유지

  String _getWeekdayString(int weekday) {
    switch (weekday) {
      case DateTime.sunday:
        return 'S';
      case DateTime.monday:
        return 'M';
      case DateTime.tuesday:
        return 'T';
      case DateTime.wednesday:
        return 'W';
      case DateTime.thursday:
        return 'T';
      case DateTime.friday:
        return 'F';
      case DateTime.saturday:
        return 'S';
      default:
        return '';
    }
  }

  bool _isDateInWorkPeriod(
      DateTime date, DateTime workStart, DateTime workEnd) {
    final compareDate = DateTime(date.year, date.month, date.day);
    final compareWorkStart =
        DateTime(workStart.year, workStart.month, workStart.day);
    final compareWorkEnd = DateTime(workEnd.year, workEnd.month, workEnd.day);

    return !compareDate.isBefore(compareWorkStart) &&
        !compareDate.isAfter(compareWorkEnd);
  }

  // Widget _buildDayItem(String weekday, String date, bool isSelected) {
  //   return Column(
  //     children: [
  //       Text(weekday, style: FontSystem.KR14R),
  //       const SizedBox(height: 8),
  //       Container(
  //         width: 8,
  //         height: 8,
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: isSelected ? ColorSystem.blue.shade500 : Colors.transparent,
  //         ),
  //       ),
  //       Text(date, style: FontSystem.KR14R),
  //     ],
  //   );
  // }
}
