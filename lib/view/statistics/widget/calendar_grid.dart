import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/functions/day_util.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_widget.dart';
import 'package:rebootOffice/view_model/statistics/statistics_view_model.dart';

class CalendarGrid extends BaseWidget<StatisticsViewModel> {
  const CalendarGrid({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorSystem.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildStatusSummary(),
          _buildTopBar(),
          _buildCalendarBody(),
        ],
      ),
    );
  }

  Widget _buildStatusSummary() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatusItem(
              'assets/icons/common/work_circle_check.svg',
              viewModel.attendanceState[viewModel.selectedIndex].success ?? 0,
              Colors.green,
            ),
            const SizedBox(width: 12),
            _buildStatusItem(
              'assets/icons/common/work_circle_warning.svg',
              viewModel.attendanceState[viewModel.selectedIndex].unclear ?? 0,
              Colors.orange,
            ),
            const SizedBox(width: 12),
            _buildStatusItem(
              'assets/icons/common/work_circle_dangerous.svg',
              viewModel.attendanceState[viewModel.selectedIndex].fail ?? 0,
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(String svgPath, int count, Color color) {
    return Row(
      children: [
        SvgPicture.asset(
          svgPath,
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          '$count일',
          style: FontSystem.KR12M.copyWith(color: color),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildTab('출근/퇴근', 0),
              _buildTab('식사 업무', 1),
              _buildTab('외근 업무', 2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    return Obx(
      () => Expanded(
        child: GestureDetector(
          onTap: () => viewModel.setSelectedIndex(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: viewModel.selectedIndex == index
                  ? ColorSystem.blue.shade500
                  : ColorSystem.grey.shade200,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            child: Text(
              title,
              style: FontSystem.KR14B.copyWith(
                color: viewModel.selectedIndex == index
                    ? ColorSystem.white
                    : ColorSystem.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarBody() {
    return Obx(() {
      final dates = _getDatesInRange(viewModel.selectedIndex);
      return Container(
        decoration: BoxDecoration(
          color: ColorSystem.blue.shade500,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
        ),
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: dates.length,
          itemBuilder: (context, index) {
            final date = dates[index];
            final calendarItems = viewModel
                .attendanceState[viewModel.selectedIndex].calendarItems;

            // 해당 날짜의 status 찾기
            String status = '미완';
            for (var item in calendarItems) {
              if (isSameDay(date, item.itemTime)) {
                status = item.status;
                break;
              }
            }

            return _buildDateCell(date, status);
          },
        ),
      );
    });
  }

  Widget _buildDateCell(DateTime date, String status) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: ColorSystem.grey.shade500,
          width: 1,
        ),
      ),
      child: status == '미완'
          ? Center(
              child: Text(
                '${date.month}월 ${date.day}일',
                style:
                    FontSystem.KR14M.copyWith(color: ColorSystem.grey.shade500),
              ),
            )
          : _getStatusIcon(status),
    );
  }

  Widget _getStatusIcon(String status) {
    switch (status) {
      case '업무불참':
        return SvgPicture.asset(
          'assets/icons/common/work_circle_dangerous.svg',
          width: 16,
          height: 16,
          color: Colors.red,
        );
      case '완료':
        return SvgPicture.asset(
          'assets/icons/common/work_circle_check.svg',
          width: 16,
          height: 16,
          color: Colors.green,
        );
      case '노력필요':
        return SvgPicture.asset(
          'assets/icons/common/work_circle_warning.svg',
          width: 16,
          height: 16,
          color: Colors.yellow,
        );
      default:
        return SvgPicture.asset('assets/icons/common/app-logo.svg',
            width: 16, height: 16, color: ColorSystem.blue.shade500);
    }
  }

  List<DateTime> _getDatesInRange(int index) {
    if (viewModel.attendanceState == null ||
        index >= viewModel.attendanceState.length) {
      return [];
    }

    final List<DateTime> dates = [];
    final startDate = viewModel.attendanceState[index].workStartTime;
    final endDate = viewModel.attendanceState[index].workEndTime;

    // null 체크 추가
    if (startDate == null || endDate == null) {
      return [];
    }

    // 날짜 차이 계산
    final difference = endDate.difference(startDate).inDays;
    LogUtil.debug(difference);
    // 날짜 범위가 너무 크면 빈 배열 반환
    if (difference > 31 || difference < 0) {
      return [];
    }

    for (var i = 0; i <= difference; i++) {
      dates.add(startDate.add(Duration(days: i)));
    }

    return dates;
  }
}
