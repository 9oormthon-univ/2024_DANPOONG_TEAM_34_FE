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
      child: Obx(
        () => Column(
          children: [
            _buildTopBar(),
            _buildAttendanceStamps(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        _buildTab('출근/퇴근', 0),
        _buildTab('식사 업무', 1),
        _buildTab('외근 업무', 2),
      ],
    );
  }

  Widget _buildTab(String title, int index) {
    return Expanded(
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
    );
  }

  Widget _buildAttendanceStamps() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
      decoration: BoxDecoration(
        color: ColorSystem.blue.shade500,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Obx(
        () => GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
          ),
          itemCount: viewModel.getCurrentAttendanceState().length, // 예시로 15일
          itemBuilder: (context, index) {
            return _buildStamp(index);
          },
        ),
      ),
    );
  }

  Widget _buildStamp(int index) {
    // 예시 데이터 - 실제로는 동적으로 계산되어야 함
    final date = DateTime.now().add(Duration(days: index));
    final status = _getMockStatus(index); // 출석 상태 가져오기

    return Column(
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorSystem.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Center(
            child: _getStampIcon(status),
          ),
        ),
      ],
    );
  }

  Widget _getStampIcon(AttendanceStatus data) {
    switch (data) {
      case AttendanceStatus.complete:
        return SvgPicture.asset('assets/icons/common/work_circle_check.svg',
            width: 62);
      case AttendanceStatus.warning:
        return SvgPicture.asset('assets/icons/common/work_circle_warning.svg',
            width: 62);
      case AttendanceStatus.absent:
        return SvgPicture.asset('assets/icons/common/work_circle_dangerous.svg',
            width: 62);
      case AttendanceStatus.upcoming:
        return Text(
          '일',
          style: FontSystem.KR10B.copyWith(
            color: ColorSystem.white.withOpacity(0.7),
          ),
        );
    }
  }

// 상태값 가져오기 (예시)
  AttendanceStatus _getMockStatus(int dayIndex) {
    if (dayIndex < 2) return AttendanceStatus.complete;
    if (dayIndex == 2) return AttendanceStatus.warning;
    if (dayIndex == 4) return AttendanceStatus.absent;
    return AttendanceStatus.upcoming;
  }
}
