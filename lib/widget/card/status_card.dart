import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';

class StatusCard extends StatefulWidget {
  const StatusCard({Key? key}) : super(key: key);

  @override
  State<StatusCard> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPressed = !isPressed;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        width: Get.width * 0.9,
        height: 120,
        decoration: BoxDecoration(
          color: ColorSystem.blue.shade500,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isPressed ? '목표까지 앞으로 7일' : '일상회복팀 | 인턴',
              style: FontSystem.KR14B.copyWith(color: ColorSystem.white),
            ),
            const Spacer(),
            _buildLevels(),
            _buildProgressSteps(),
          ],
        ),
      ),
    );
  }

  Widget _buildLevels() {
    // 예시 값들 (실제 앱에서는 이 값들을 동적으로 설정해야 함)
    final totalDays = 30; // 선택한 총 일수
    final spentDays = 5; // 현재까지 보낸 일수

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isPressed ? '1일' : '인턴',
          style: FontSystem.KR12B.copyWith(color: ColorSystem.white),
        ),
        const Spacer(),
        Text(
          isPressed ? '${(totalDays - spentDays) ~/ 2}일' : '수습',
          style: FontSystem.KR12B.copyWith(color: ColorSystem.white),
        ),
        const Spacer(),
        Text(
          isPressed ? '${totalDays}일' : '정식사원',
          style: FontSystem.KR12B.copyWith(color: ColorSystem.white),
        ),
      ],
    );
  }

  Widget _buildProgressSteps() {
    final currentStep = 5;

    return Row(
      children: List.generate(10, (index) {
        final fillPercentage = index < currentStep
            ? 100.0
            : index == currentStep
                ? 33.33
                : 0.0;
        final isFirst = index == 0;
        final isLast = index == 9;
        return _buildProgressStep(isFirst, isLast, fillPercentage / 100, index);
      }),
    );
  }

  Widget _buildProgressStep(
      bool isFirst, bool isLast, double fillPercentage, int index) {
    return Row(
      children: [
        Container(
          width: Get.width * 0.072,
          height: 12,
          decoration: BoxDecoration(
            borderRadius: isFirst
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))
                : isLast
                    ? const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))
                    : null,
            color: ColorSystem.white.withOpacity(0.3),
          ),
          child: ClipRRect(
            borderRadius: isFirst
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))
                : isLast
                    ? const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))
                    : BorderRadius.zero,
            child: Row(
              children: [
                Expanded(
                  flex: (fillPercentage * 100).toInt(),
                  child: Container(
                    color: ColorSystem.white,
                  ),
                ),
                Expanded(
                  flex: ((1 - fillPercentage) * 100).toInt(),
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
        if (index < 9) const SizedBox(width: 4),
      ],
    );
  }
}
