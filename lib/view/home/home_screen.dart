import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/functions/enumToKorean.dart';
import 'package:rebootOffice/utility/static/app_routes.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view/home/widget/home_business_card.dart';
import 'package:rebootOffice/view/home/widget/week_calendar_card.dart';
import 'package:rebootOffice/view/home/widget/week_selector_dialog.dart';
import 'package:rebootOffice/view_model/home/home_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';
import 'package:rebootOffice/widget/card/status_card.dart';
import 'package:rebootOffice/widget/card/work_alert_card.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});
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
      backgroundColor: Colors.white,
      color: ColorSystem.blue,
      onRefresh: () async {
        await viewModel.readWeek();
        await viewModel.readDailyWork();
        await viewModel.readUserState();
      },
      child: Obx(
        () => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                const HomeBusinessCard(),
                const StatusCard(),
                const WelcomeCard(),
                _buildSchedule(),
                const SizedBox(
                  height: 16,
                ),
                _buildCalendarSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          viewModel.isNextDay()
              ? '${viewModel.userState.name}님 잘 해내셨어요!!\n지금처럼 계속해서 힘내 보아요'
              : '${viewModel.userState.name}님 잘 해내고 있어요!\n조금씩 나아가 보아요',
          style: FontSystem.KR24B,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSchedule() {
    if (viewModel.isNextDay()) {
      return Container(); // 빈 컨테이너 반환
    }

    return Column(
      children: [
        const SizedBox(height: 24),
        const Text(
          '오늘 근무 리스트',
          style: FontSystem.KR16B,
        ),
        const SizedBox(height: 16),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.dailyWorkState.length,
              itemBuilder: (context, index) {
                final work = viewModel.dailyWorkState[index];
                //startTime 이 07:00 일 때, 현재 시간이랑 비교해서 색 칠해주기

                return _buildScheduleItem(
                  startTime: work.startTime, // DateTime 객체 직접 전달
                  endTime: work.endTime, // DateTime 객체 직접 전달
                  activity: enumToKorean(work.mission),
                  isDone: work.status == 'SUCCESS',
                  isFirst: index == 0,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleItem({
    required String startTime,
    required String endTime,
    required String activity,
    required bool isDone,
    required bool isFirst,
  }) {
    final now = DateTime.now();
    final startParts = startTime.split(':');
    final endParts = endTime.split(':');
    final start = DateTime(now.year, now.month, now.day,
        int.parse(startParts[0]), int.parse(startParts[1]));
    final end = DateTime(now.year, now.month, now.day, int.parse(endParts[0]),
        int.parse(endParts[1]));
    final isCurrentTime = now.isAfter(start) && now.isBefore(end);
    final isPast = now.isAfter(end);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDone || isPast
            ? ColorSystem.grey.shade200
            : isCurrentTime
                ? const Color(0xFF0066FF).withOpacity(0.1)
                : ColorSystem.white,
        borderRadius: isFirst
            ? const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))
            : null,
        border: Border(
          bottom: BorderSide(
            color: isCurrentTime ? ColorSystem.Blue : ColorSystem.grey.shade500,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            startTime,
            style: FontSystem.KR18M.copyWith(
              color: ColorSystem.black,
            ),
          ),
          Text(
            ' ~ $endTime',
            style: FontSystem.KR18M.copyWith(
              color: ColorSystem.black,
            ),
          ),
          const Spacer(),
          if (isDone)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                'assets/icons/common/circle_check.svg',
                height: 24,
                colorFilter: ColorFilter.mode(
                  ColorSystem.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
          Text(
            activity,
            style: FontSystem.KR18M.copyWith(
              color: isPast
                  ? ColorSystem.black
                  : isCurrentTime
                      ? ColorSystem.black
                      : ColorSystem.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  //-----------------주간 캘린더 위젯 구현 -----------------//
  Widget _buildCalendarSection(BuildContext context) {
    return WeekCalendarCard(
      weekState: viewModel.weekState,
      onWeekSelect: () {
        showDialog(
          context: context,
          builder: (context) => WeekSelectorDialog(
            weekState: viewModel.weekState,
            onWeekSelected: (selectedDate) {
              // ViewModel에서 선택된 날짜 업데이트
            },
          ),
        );
      },
      onReportTap: () {
        Get.toNamed(Routes.STATISTICS_DETAIL,
            arguments: viewModel.selectedDate.value);
        // 업무일지 보기 로직
      },
    );
  }

  //-----------------주간 캘린더 위젯 구현 끝 -----------------//
}
