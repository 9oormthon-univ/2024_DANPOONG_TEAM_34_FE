import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/model/statistics/attendance_state.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_widget.dart';
import 'package:rebootOffice/view_model/statistics/statistics_view_model.dart';

class AttendanceCard extends BaseWidget<StatisticsViewModel> {
  const AttendanceCard({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorSystem.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildAttendanceStatus(),
          _buildTopBar(),
          _buildAttendanceGrid(),
        ],
      ),
    );
  }

  Widget _buildAttendanceStatus() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatusItem(
              'assets/icons/common/work_circle_check.svg',
              viewModel.attendanceState[0].success,
              Colors.green,
            ),
            const SizedBox(width: 12),
            _buildStatusItem(
              'assets/icons/common/work_circle_warning.svg',
              viewModel.attendanceState[0].unclear,
              Colors.orange,
            ),
            const SizedBox(width: 12),
            _buildStatusItem(
              'assets/icons/common/work_circle_dangerous.svg',
              viewModel.attendanceState[0].fail,
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
          '$count개',
          style: FontSystem.KR12M.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          bottom: BorderSide(
            color: ColorSystem.grey.shade200,
            width: 1,
          ),
        ),
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

  Widget _buildAttendanceGrid() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorSystem.blue.shade500,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Obx(() {
        // 데이터가 없을 때의 예외 처리
        if (viewModel.attendanceState.isEmpty) {
          return const Center(
            child: Text(
              '데이터가 없습니다',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final currentState = viewModel.attendanceState[viewModel.selectedIndex];
        final items = currentState.calendarItems;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final status = _getStatusForDate(index, items);
            return _buildDateCircle(status);
          },
        );
      }),
    );
  }

  Widget _buildDateCircle(String status) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Center(
        child: _getStatusIcon(status),
      ),
    );
  }

  Widget _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case '완료':
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 2),
              ),
            ),
            Center(
              child: SvgPicture.asset(
                'assets/icons/common/work_circle_check.svg',
                color: Colors.green,
              ),
            ),
          ],
        );
      case '노력필요':
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.orange, width: 2),
              ),
            ),
            Center(
              child: SvgPicture.asset(
                'assets/icons/common/work_circle_warning.svg',
                color: Colors.orange,
              ),
            ),
          ],
        );
      case '업무불참':
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red, width: 2),
              ),
            ),
            Center(
              child: SvgPicture.asset(
                'assets/icons/common/work_circle_dangerous.svg',
                color: Colors.red,
              ),
            ),
          ],
        );
      default:
        return Text(
          '일',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        );
    }
  }

  String _getStatusForDate(int index, List<CalendarItem> items) {
    final item = items.firstWhere(
      (item) => index == item.itemTime.day - 1,
      orElse: () => CalendarItem(
        itemTime: DateTime.now(),
        status: 'upcoming',
      ),
    );
    return item.status;
  }
}
