import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view_model/home/home_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';

import 'widget/card/business_card.dart';

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
    return SingleChildScrollView(
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
            _buildSchedule(),
            _buildCalendarSection(),
          ],
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
            child: Column(
              children: [
                _buildScheduleItem('08:00', '출근', true, true),
                _buildScheduleItem('09:00', '아침식사', true, false),
                _buildScheduleItem('12:00', '점심식사', true, false),
                _buildScheduleItem('15:00', '산책', false, false),
                _buildScheduleItem('23:00', '저녁식사', false, false),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleItem(
    String time,
    String activity,
    bool isDone,
    bool isFirst,
  ) {
    // 현재 시간과 비교하기 위해 time 문자열을 DateTime으로 변환
    final now = DateTime.now();
    final timeComponents = time.split(':');
    final endTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(timeComponents[0]) + 1,
      int.parse(timeComponents[1]),
    );
    final endTimeString = DateFormat('HH:mm').format(endTime);

    final scheduleTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(timeComponents[0]),
      int.parse(timeComponents[1]),
    );

    // 부모 위젯에서 rebuild될 때마다 현재 시간 체크
    final isCurrentTime = now.isAfter(scheduleTime) &&
        now.isBefore(scheduleTime.add(const Duration(hours: 1)));

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDone
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
            color: ColorSystem.grey.shade500,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            time,
            style: FontSystem.KR18M.copyWith(
              color: ColorSystem.black,
            ),
          ),
          Text(
            (' ~ $endTimeString'),
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
  Widget _buildCalendarSection() {
    final now = DateTime.now();
    final weekNumber = ((now.day - 1) ~/ 7) + 1;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: ColorSystem.grey.shade200, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${now.year}년 ${now.month}월 ${weekNumber}주차',
                style: FontSystem.KR16B,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_down),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildWeekCalendar(),
          const SizedBox(height: 16),
          RoundedRectangleTextButton(
            onPressed: () {},
            width: Get.width,
            backgroundColor: ColorSystem.blue.shade500,
            padding: const EdgeInsets.symmetric(vertical: 18),
            text: '업무일지 보러가기',
            textStyle: FontSystem.KR16B.copyWith(color: ColorSystem.white),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekCalendar() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final days = List.generate(
      7,
      (index) {
        final date = weekStart.add(Duration(days: index));
        return {
          'weekday': _getWeekdayString(date.weekday),
          'date': date.day.toString(),
          'isSelected': date.isBefore(now) ||
              date.isAtSameMomentAs(DateTime(now.year, now.month, now.day)),
        };
      },
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days
          .map((day) => _buildDayItem(
                day['weekday'] as String,
                day['date'] as String,
                day['isSelected'] as bool,
              ))
          .toList(),
    );
  }

  String _getWeekdayString(int weekday) {
    switch (weekday) {
      case DateTime.sunday:
        return 'S';
      case DateTime.monday:
        return 'M';
      case DateTime.tuesday:
        return 'T';
      case DateTime.wednesday:
        return 'W';
      case DateTime.thursday:
        return 'T';
      case DateTime.friday:
        return 'F';
      case DateTime.saturday:
        return 'S';
      default:
        return '';
    }
  }

  Widget _buildDayItem(String weekday, String date, bool isSelected) {
    return Column(
      children: [
        Text(weekday, style: FontSystem.KR14R),
        const SizedBox(height: 8),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? ColorSystem.blue.shade500 : Colors.transparent,
          ),
        ),
        Text(date, style: FontSystem.KR14R),
      ],
    );
  }
//-----------------주간 캘린더 위젯 구현 끝 -----------------//
}
