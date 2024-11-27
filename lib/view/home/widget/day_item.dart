import 'package:flutter/material.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';

class DayItem extends StatelessWidget {
  final String weekday;
  final String date;
  final bool isSelected;
  final bool isActive;
  final VoidCallback onTap;

  const DayItem({
    super.key,
    required this.weekday,
    required this.date,
    required this.isSelected,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSelected ? onTap : null,
      child: Column(
        children: [
          Text(weekday, style: FontSystem.KR14R),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              width: 40,
              height: 44,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                  color:
                      isActive ? const Color(0xFFF7F7FB) : Colors.transparent,
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  Text(date, style: FontSystem.KR14B),
                  const SizedBox(height: 4),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? ColorSystem.blue.shade500
                          : Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
