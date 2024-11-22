import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_widget.dart';
import 'package:rebootOffice/view_model/statistics/statistics_view_model.dart';

class StatusCard extends BaseWidget<StatisticsViewModel> {
  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          viewModel.setIsTouched(!viewModel.isTouched);
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
                viewModel.isTouched
                    ? '목표까지 앞으로 ${viewModel.periodState.remainPeriod} 일'
                    : '일상회복팀 | ${_getEmployeeStatus()}',
                style: FontSystem.KR14B.copyWith(color: ColorSystem.white),
              ),
              const Spacer(),
              _buildLevels(),
              _buildProgressSteps(),
            ],
          ),
        ),
      ),
    );
  }

  String _getEmployeeStatus() {
    final totalPeriod = viewModel.periodState.contractPeriod;
    final remainPeriod = viewModel.periodState.remainPeriod;
    final progressPeriod = viewModel.periodState.progressPeriod;

    if (remainPeriod <= 0) {
      return '정식사원';
    } else if (progressPeriod >= (totalPeriod / 2) - 1) {
      return '수습';
    } else {
      return '인턴';
    }
  }

  Widget _buildLevels() {
    // 예시 값들 (실제 앱에서는 이 값들을 동적으로 설정해야 함)
    final totalDays = viewModel.periodState.contractPeriod; // 선택한 총 일수

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          viewModel.isTouched ? '1일' : '인턴',
          style: FontSystem.KR12B.copyWith(color: ColorSystem.white),
        ),
        const Spacer(),
        Text(
          viewModel.isTouched ? '${(totalDays) ~/ 2}일' : '수습',
          style: FontSystem.KR12B.copyWith(color: ColorSystem.white),
        ),
        const Spacer(),
        Text(
          viewModel.isTouched ? '${totalDays}일' : '정식사원',
          style: FontSystem.KR12B.copyWith(color: ColorSystem.white),
        ),
      ],
    );
  }

  Widget _buildProgressSteps() {
    final tenPercent = viewModel.periodState.contractPeriod ~/ 10;
    //전체 일 / 10 으로 퍼센트 생성
    final currentStep =
        viewModel.periodState.progressPeriod / tenPercent; // 현재까지 보낸 일수

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
          width: Get.width * 0.077,
          height: 14,
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
            boxShadow: [
              BoxShadow(
                color: ColorSystem.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
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
        if (index < 9) const SizedBox(width: 1),
      ],
    );
  }
}
