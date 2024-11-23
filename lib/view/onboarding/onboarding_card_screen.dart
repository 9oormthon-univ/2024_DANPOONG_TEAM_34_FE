import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utility/system/color_system.dart';
import '../../view_model/onboarding/onboarding_view_model.dart';
import '../../widget/appbar/default_white_back_appbar.dart';
import '../base/base_screen.dart';
import 'widget/card/business_card_big.dart';

class OnboardingCardScreen extends BaseScreen<OnboardingViewModel> {
  const OnboardingCardScreen({super.key});

  final double radian = 90 * math.pi / 180;

  @override
  bool get wrapWithInnerSafeArea => false;

  @override
  bool get setBottomInnerSafeArea => false;

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: DefaultWhiteBackAppBar(
          showBackButton: true,
          title: ' ',
          onBackPress: () => {Get.back()},
          centerTitle: true,
        ));
  }

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlipCard(
                  frontWidget: BusinessCardBig(
                      name: viewModel.userName,
                      nameEn: viewModel.userNameEn,
                      department: '인턴',
                      email: 'rebootOffice@gmail.com',
                      phone: '010-1234-5678'),
                  backWidget: _buildBack(),
                  controller: viewModel.flipCardController,
                  rotateSide: RotateSide.right,
                  axis: FlipAxis.vertical,
                  animationDuration: const Duration(seconds: 1)),
              const Spacer(),
              _buildFlipBotton(),
            ]));
  }

  Widget _buildBack() {
    return Transform.rotate(
        angle: radian,
        child: Transform.scale(
            scale: 1.55,
            child: Transform.translate(
                offset: const Offset(
                  124,
                  0,
                ),
                child: AspectRatio(
                    aspectRatio: 2 / 1.4,
                    child: Container(
                        width: Get.width,
                        height: 500,
                        margin: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 0),
                        decoration: BoxDecoration(
                          color: ColorSystem.blue.shade500,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: ColorSystem.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/common/app-logo.svg',
                              width: 90,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SvgPicture.asset(
                              'assets/icons/appbar/header-logo.svg',
                              width: 180,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            )
                          ],
                        ))))));
  }

  Widget _buildFlipBotton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 56),
      child: GestureDetector(
        onTap: () {
          viewModel.flipCardController.flipcard();
        },
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade700),
              borderRadius: BorderRadius.circular(50)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset('assets/icons/common/card-flip.svg'),
          ),
        ),
      ),
    );
  }
}
