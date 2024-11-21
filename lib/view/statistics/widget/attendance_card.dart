import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';

class AttendanceCard extends StatefulWidget {
  const AttendanceCard({Key? key}) : super(key: key);

  @override
  State<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard> {
  int selectedTab = 0; // 0: 출근/퇴근, 1: 식사업무, 2: 외근업무

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorSystem.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildTopBar(),
          _buildAttendanceStamps(),
        ],
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
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selectedTab == index
                ? ColorSystem.blue.shade500
                : ColorSystem.grey.shade200,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: Text(
            title,
            style: FontSystem.KR14B.copyWith(
              color: selectedTab == index
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
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        itemCount: 21, // 예시로 15일
        itemBuilder: (context, index) {
          return _buildStamp(index);
        },
      ),
    );
  }

  Widget _buildStamp(int index) {
    // 예시 데이터 - 실제로는 동적으로 계산되어야 함
    final date = DateTime.now().add(Duration(days: index));
    final status = _getMockStampStatus(index); // 출석 상태 가져오기

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
            child: _getStampIcon(date, status),
          ),
        ),
      ],
    );
  }

  Widget _getStampIcon(DateTime date, String status) {
    switch (status) {
      case '완료':
        return SvgPicture.asset('assets/icons/common/work_circle_check.svg',
            width: 62);
      case '노력필요':
        return SvgPicture.asset('assets/icons/common/work_circle_warning.svg',
            width: 62);
      case '업무불참':
        return SvgPicture.asset('assets/icons/common/work_circle_dangerous.svg',
            width: 62);
      default:
        return Container(
          child: Text(
            '${date.month}월 ${date.day}일',
            style: FontSystem.KR10B.copyWith(
              color: ColorSystem.white.withOpacity(0.7),
            ),
          ),
        );
    }
  }

  String _getMockStampStatus(int index) {
    // 예시 로직 - 실제로는 서버에서 받아온 데이터를 사용해야 함
    if (index < 2) return '완료';
    if (index == 2) return '노력필요';
    if (index == 4) return '업무불참';
    return '';
  }
}
