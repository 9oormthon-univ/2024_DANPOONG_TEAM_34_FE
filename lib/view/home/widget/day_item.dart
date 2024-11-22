import 'package:flutter/material.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';

class DayItem extends StatelessWidget {
  final String weekday;
  final String date;
  final bool isSelected;

  const DayItem({
    Key? key,
    required this.weekday,
    required this.date,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(weekday, style: FontSystem.KR14R),
        const SizedBox(height: 8),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? ColorSystem.blue.shade500 : Colors.transparent,
          ),
        ),
        Text(date, style: FontSystem.KR14R),
      ],
    );
  }
}
