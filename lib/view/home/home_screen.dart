import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view_model/home/home_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';

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
        ));
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
            const SizedBox(height: 16),
            const BusinessCard(
              name: '홍규진',
              nameEn: 'Hong Kyujin',
              department: '개발',
              email: 'hkj0206@dgu.ac.kr',
              phone: '010-5820-4625',
            ),
            const SizedBox(height: 24),
            _buildSchedule(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      '규진님 잘 해내고 있어요!\n 조금씩 나아가 보아요',
      style: FontSystem.KR24B,
    );
  }

  Widget _buildSchedule() {
    return Column(
      children: [
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
                _buildScheduleItem('09:00 ~ 10:00', '아침식사', true, false),
                _buildScheduleItem('12:00 ~ 13:00', '점심식사', true, false),
                _buildScheduleItem('15:00 ~ 16:00', '산책', false, false),
                _buildScheduleItem('18:00 ~ 19:00', '저녁식사', false, false),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleItem(
      String time, String activity, bool isDone, bool isFirst) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDone ? ColorSystem.grey.shade200 : ColorSystem.white,
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
          Text(time, style: FontSystem.KR18M),
          const Spacer(),
          if (isDone)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(
                'assets/icons/common/circle_check.svg',
                height: 24,
              ),
            ),
          Text(activity, style: FontSystem.KR18M),
        ],
      ),
    );
  }
}
