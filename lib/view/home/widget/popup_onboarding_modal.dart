import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';
import 'package:rebootOffice/widget/card/business_card.dart';

class PopupOnboardingModal extends StatefulWidget {
  const PopupOnboardingModal({super.key});

  @override
  State<PopupOnboardingModal> createState() => _PopupOnboardingModalState();
}

class _PopupOnboardingModalState extends State<PopupOnboardingModal> {
  late final PageController pageController;
  int _currentPage = 0;

  String _currentSvg = 'assets/images/popup_status_1.svg';

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    pageController.removeListener(_onPageChanged); // 리스너 제거
    pageController.dispose(); // 메모리 누수 방지를 위해 컨트롤러 해제
    super.dispose();
  }

  void _onPageChanged() {
    setState(() {
      _currentPage = pageController.page!.round(); // 페이지 변경 시 인덱스를 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(4),
          width: 350,
          height: 470,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: [
                    _buildFirstPage(),
                    _buildSecondPage(),
                    _buildThirdPage(),
                  ],
                ),
              ),
              _buildPaginationIndicator(_currentPage),
              _buildButton(),
            ],
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close,
              color: ColorSystem.grey.shade800,
              size: 28,
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildPaginationIndicator(int step) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          // 페이지 수에 맞게 3개로 설정
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: step == index ? 14 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: step == index
                  ? const Color(0xFF111111)
                  : const Color(0xFFcccccc),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTitle(String title, String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: FontSystem.KR20SB,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            label,
            style: FontSystem.KR14R.copyWith(color: ColorSystem.grey.shade600),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget _buildFirstPage() {
    return Column(
      children: [
        _buildTitle('명함을 확인해 보세요!', '현재 직급 박스를 클릭하면 전체\n명함을 확인할 수 있습니다'),
        Transform.scale(
          scale: 0.9,
          child: const BusinessCard(
              name: '이희균',
              nameEn: 'Heekyun Lee',
              department: '정식사원',
              email: 'nuykeeh@gmail.com',
              phone: '010-1234-5678'),
        ),
      ],
    );
  }

  Widget _buildSecondPage() {
    return Column(
      children: [
        _buildTitle('남은 일정을 확인하세요!', '목표 박스를 눌러 남은 날짜와 다음\n직급까지의 여정을 확인하세요.'),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            // 클릭 시 SVG 파일 변경
            setState(() {
              _currentSvg = _currentSvg == 'assets/images/popup_status_1.svg'
                  ? 'assets/images/popup_status_2.svg' // 첫 번째 SVG에서 두 번째 SVG로 변경
                  : 'assets/images/popup_status_1.svg'; // 두 번째 SVG에서 첫 번째 SVG로 변경
            });
          },
          child: SvgPicture.asset(
            _currentSvg,
            width: 270,
          ),
        )
      ],
    );
  }

  Widget _buildThirdPage() {
    return Column(
      children: [
        _buildTitle('근무리스트를 확인하세요!', '현재 진행 중인 미션과 완료된\n미션을 쉽게 확인하세요.'),
        const SizedBox(
          height: 20,
        ),
        SvgPicture.asset(
          'assets/images/popup_list.svg',
          width: 270,
        )
      ],
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: _currentPage == 2
              ? ColorSystem.blue.shade500
              : ColorSystem.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: RoundedRectangleTextButton(
          text: '이해했어요',
          textStyle: FontSystem.KR16SB.copyWith(
              color: _currentPage == 2
                  ? ColorSystem.white
                  : ColorSystem.grey.shade600),
          backgroundColor: _currentPage == 2
              ? ColorSystem.blue.shade500
              : ColorSystem.grey.shade200,
          padding: const EdgeInsets.symmetric(vertical: 16),
          onPressed: () => {_currentPage == 2 ? Navigator.pop(context) : null},
        ),
      ),
    );
  }
}
