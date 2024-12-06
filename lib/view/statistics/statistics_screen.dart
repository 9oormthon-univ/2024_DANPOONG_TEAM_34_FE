import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/functions/level_util.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view_model/statistics/statistics_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';
import 'package:rebootOffice/widget/card/status_card.dart';

import 'widget/calendar_grid.dart';

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
    return RefreshIndicator(
      onRefresh: () async {
        // 새로고침 시 필요한 데이터 다시 불러오기
        viewModel.onInit();
      },
      child: Obx(
        () => SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(), // 필수: RefreshIndicator가 작동하기 위해 필요
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                const SizedBox(height: 24),
                const StatusCard(),
                const SizedBox(height: 24),
                const CalendarGrid(),
                // 스크롤 가능한 영역 확보를 위한 추가 공간
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      '${viewModel.userName} ${getEmployeeStatus(viewModel.periodState.contractPeriod, viewModel.periodState.remainPeriod, viewModel.periodState.progressPeriod)}님,\n벌써 출근 ${viewModel.periodState.progressPeriod}일차네요!',
      style: FontSystem.KR24B,
    );
  }
}
