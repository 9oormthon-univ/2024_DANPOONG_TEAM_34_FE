import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/static/app_routes.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view/onboarding/onboarding_card_screen.dart';
import 'package:rebootOffice/view_model/onboarding/onboarding_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';
import 'package:rebootOffice/widget/card/business_card.dart';

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
          BusinessCard(
            name: viewModel.userName,
            nameEn: viewModel.userNameEn,
            department: '인턴',
            email: 'rebootOffice@gmail.com',
            phone: '010-1234-5678',
            initiallyExpanded: true,
          ),
          const SizedBox(height: 8),
          _buildNavigateToCard(),
          const Spacer(),
          _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          '환영합니다! 이제 우리 회사의\n소중한 일원이 되셨습니다.',
          style: FontSystem.KR28B,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Container(
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
            viewModel.submitUserData();
            Get.toNamed(Routes.REGISTER);
          }),
    );
  }

  Widget _buildNavigateToCard() {
    return RoundedRectangleTextButton(
      text: "명함을 확인해보세요!",
      textStyle: FontSystem.KR14M.copyWith(color: ColorSystem.Blue),
      width: 164,
      height: 54,
      backgroundColor: ColorSystem.lightBlue,
      borderSide: BorderSide(
        color: ColorSystem.Blue,
        width: 1.0,
      ),
      onPressed: () {
        Get.to(
          () => const OnboardingCardScreen(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}
