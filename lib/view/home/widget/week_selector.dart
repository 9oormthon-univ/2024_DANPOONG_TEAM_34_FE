import 'package:flutter/material.dart';
import 'package:rebootOffice/utility/system/font_system.dart';

// lib/view/home/widget/week_selector.dart
class WeekSelector extends StatelessWidget {
  final int year;
  final int month;
  final int weekNumber;
  final VoidCallback onTap;

  const WeekSelector({
    super.key,
    required this.year,
    required this.month,
    required this.weekNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$year년 $month월 $weekNumber주차',
          style: FontSystem.KR16B,
        ),
        const SizedBox(width: 8),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        //   decoration: BoxDecoration(
        //     border: Border.all(color: ColorSystem.grey.shade200),
        //     borderRadius: BorderRadius.circular(4),
        //   ),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Text(
        //         '$weekNumber주차',
        //         style: FontSystem.KR14R,
        //       ),
        //       const SizedBox(width: 4),
        //       const Icon(
        //         Icons.keyboard_arrow_down,
        //         size: 20,
        //       ),
        //     ],
        //   ),
        // ),
        const Spacer(),
      ],
    );
  }
}

// lib/view/home/widget/week_selector_dialog.dart
