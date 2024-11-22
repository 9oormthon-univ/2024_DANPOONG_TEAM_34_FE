import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view/home/widget/card/business_card.dart';
import 'package:rebootOffice/view/onboarding/onboarding_card_screen.dart';
import 'package:rebootOffice/view_model/onboarding/onboarding_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';

class OnboardingResultScreen extends BaseScreen<OnboardingViewModel> {
  const OnboardingResultScreen({super.key});

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  bool get setBottomInnerSafeArea => true;

  @override
  Color? get screenBackgroundColor => Colors.white;

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
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: 28),
          const BusinessCard(
              name: '이희균',
              nameEn: 'Heekyunlee',
              department: '슈숩',
              email: 'nuykeeh@gmail.com',
              phone: '리부트오피스이메일'),
          const SizedBox(height: 4),
          ElevatedButton(
            onPressed: () {
              // 명함스크린으로 이동
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shadowColor: Colors.transparent,
                overlayColor: Colors.transparent,
                backgroundColor: const Color(0xffe5efff),
                fixedSize: const Size(170, 54),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                side: const BorderSide(
                    width: 1.0,
                    color: Color(
                      0xFF0066FF,
                    ))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const OnboardingCardScreen(),
                    );
                  },
                  child: Text(
                    '명함을 확인해보세요!',
                    style: FontSystem.KR14R
                        .copyWith(color: const Color(0xFF0066FF)),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 14,
                  color: Color(0xFF0066FF),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorSystem.blue.shade500,
              borderRadius: BorderRadius.circular(12),
            ),
            child: RoundedRectangleTextButton(
                text: '근로계약서 작성하러 가기',
                textStyle: FontSystem.KR16B.copyWith(
                  color: ColorSystem.white,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                onPressed: () {
                  // TO DO : Register로 이동
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          '환영합니다! 이제 우리 회사의\n소중한 일원이 되셨습니다.',
          style: FontSystem.KR24B,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}