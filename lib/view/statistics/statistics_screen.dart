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
    return Obx(
      () => SingleChildScrollView(
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
            ],
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
