import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/static/app_routes.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view/home/widget/week_calendar_card.dart';
import 'package:rebootOffice/view/home/widget/week_selector_dialog.dart';
import 'package:rebootOffice/view_model/home/home_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';
import 'package:rebootOffice/widget/card/business_card.dart';
import 'package:rebootOffice/widget/card/status_card.dart';

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
    return Obx(
      () => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              const BusinessCard(
                name: '홍규진',
                nameEn: 'Hong Kyujin',
                department: '개발',
                email: 'hkj0206@dgu.ac.kr',
                phone: '010-5820-4625',
              ),
              StatusCard(),
              //TODO-[규진] 상황에 따라 있게끔 하는 걸 구현해야함.
              // WelcomeCard(),
              _buildSchedule(),
              _buildCalendarSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          '규진님 잘 해내고 있어요!\n 조금씩 나아가 보아요',
          style: FontSystem.KR24B,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSchedule() {
    return Column(
      children: [
        const SizedBox(height: 24),
        const Text(
          '오늘 근무 리스트',
          style: FontSystem.KR14B,
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

  String enumToKorean(String value) {
    switch (value) {
      case 'FOLD':
        return '기상';
      case 'MORNING':
        return '아침식사';
      case 'LUNCH':
        return '점심식사';
      case 'DINNER':
        return '저녁식사';
      case 'LEAVE':
        return '취침';
      default:
        return value;
    }
  }

  Widget _buildScheduleItem({
    required String startTime,
    required String endTime,
    required String activity,
    required bool isDone,
    required bool isFirst,
  }) {
    final now = DateTime.now();
    // final isCurrentTime = now.isAfter(startTime) &&
    //     now.isBefore(startTime.add(const Duration(hours: 1)));

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDone
            ? ColorSystem.grey.shade200
            // : isCurrentTime
            //     ? const Color(0xFF0066FF).withOpacity(0.1)
            : ColorSystem.white,
        borderRadius: isFirst
            ? const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))
            : null,
        border: Border(
          bottom: BorderSide(
            color: ColorSystem.grey.shade500,
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
              color: ColorSystem.black,
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
        Get.toNamed(Routes.STATISTICS_DETAIL);

        // 업무일지 보기 로직
      },
    );
  }

  //-----------------주간 캘린더 위젯 구현 끝 -----------------//
}
