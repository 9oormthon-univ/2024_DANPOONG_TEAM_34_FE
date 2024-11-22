import 'package:flutter/material.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: ColorSystem.white,
        border: Border.all(color: ColorSystem.grey.shade200, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Image.asset(
              'assets/images/default_npc.png',
              width: 132,
              height: 132,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '희균님 오전 업무가 도착했어요!',
            style: FontSystem.KR16EB.copyWith(color: ColorSystem.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: RoundedRectangleTextButton(
              onPressed: () {
                // TODO: 채팅 화면으로 이동
              },
              padding: const EdgeInsets.symmetric(vertical: 12),
              text: '채팅 확인하러 가기',
              textStyle: FontSystem.KR16B.copyWith(color: ColorSystem.white),
              backgroundColor: ColorSystem.blue.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
