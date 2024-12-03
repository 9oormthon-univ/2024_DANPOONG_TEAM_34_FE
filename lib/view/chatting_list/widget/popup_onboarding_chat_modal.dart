import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';

class PopupOnboardingChatModal extends StatefulWidget {
  const PopupOnboardingChatModal({super.key});

  @override
  State<PopupOnboardingChatModal> createState() =>
      _PopupOnboardingChatModalState();
}

class _PopupOnboardingChatModalState extends State<PopupOnboardingChatModal> {
  late final PageController pageController;
  int _currentPage = 0;

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
      child: Stack(
        children: [
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
        ],
      ),
    );
  }

  Widget _buildPaginationIndicator(int step) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(2, (index) {
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
        _buildTitle('미션을 확인 하세요!', '각 미션마다 담당자가 지정되며\n1:1 채팅방이 자동으로 생성됩니다.'),
        const SizedBox(
          height: 28,
        ),
        Image.asset(
          'assets/images/popup_chat.png',
          width: 270,
        ),
        // SvgPicture.asset(
        //   'assets/images/popup_chat.svg',
        //   width: 270,
        // )
      ],
    );
  }

  Widget _buildSecondPage() {
    return Column(
      children: [
        _buildTitle(
            '미션을 보고 해보세요!', '채팅방에서 미션이 주어지면\n‘보고하기’ 버튼을 통해 간편하게\n미션 보고를 완료하세요'),
        const SizedBox(
          height: 8,
        ),
        Image.asset(
          'assets/images/popup_chatroom.png',
          width: 270,
        ),
        // SvgPicture.asset(
        //   'assets/images/popup_chatroom.svg',
        //   width: 270,
        // )
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
              color: _currentPage == 1
                  ? ColorSystem.white
                  : ColorSystem.grey.shade600),
          backgroundColor: _currentPage == 1
              ? ColorSystem.blue.shade500
              : ColorSystem.grey.shade200,
          padding: const EdgeInsets.symmetric(vertical: 16),
          onPressed: () => {_currentPage == 1 ? Navigator.pop(context) : null},
        ),
      ),
    );
  }
}
