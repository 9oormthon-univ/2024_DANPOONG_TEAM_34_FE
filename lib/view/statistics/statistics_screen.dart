import 'package:flutter/material.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view_model/statistics/statistics_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';
import 'package:rebootOffice/widget/card/status_card.dart';

class StatisticsScreen extends BaseScreen<StatisticsViewModel> {
  const StatisticsScreen({super.key});
  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  bool get setBottomInnerSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: DefaultSvgAppBar(
        svgPath: 'assets/icons/appbar/header-logo.svg',
        height: 15,
        showBackButton: false,
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            StatusCard(),
            const SizedBox(height: 24),
            _buildAttendanceList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    //TODO-[규진] 가변 값으로 변환해야함
    return const Text(
      '규진 인턴님!\n벌써 출근 8일차네요!',
      style: FontSystem.KR24B,
    );
  }

  //-----------------카드 위젯 구현 끝 -----------------//

  Widget _buildAttendanceList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildTabButton('출근/퇴근', true),
            _buildTabButton('식사 업무', false),
            _buildTabButton('외근 업무', false),
          ],
        ),
        const SizedBox(height: 16),
        _buildAttendanceGrid(),
      ],
    );
  }

  Widget _buildTabButton(String text, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorSystem.blue.shade500
              : ColorSystem.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: FontSystem.KR14B.copyWith(
            color: isSelected ? ColorSystem.white : ColorSystem.black,
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 16,
      itemBuilder: (context, index) {
        return _buildAttendanceItem(index);
      },
    );
  }

  Widget _buildAttendanceItem(int index) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ColorSystem.blue.shade500),
      ),
      child: Center(
        child: Text(
          '11월 ${23 + index}일',
          style: FontSystem.KR12R,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
