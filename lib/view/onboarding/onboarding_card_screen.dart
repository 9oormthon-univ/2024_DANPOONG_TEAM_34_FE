import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/onboarding/onboarding_view_model.dart';
import '../../widget/appbar/default_white_back_appbar.dart';
import '../base/base_screen.dart';
import 'widget/card/business_card_big.dart';

class OnboardingCardScreen extends BaseScreen<OnboardingViewModel> {
  const OnboardingCardScreen({super.key});

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
              const BusinessCardBig(
                  name: '이희균',
                  nameEn: 'Heekyunlee',
                  department: '슈숩',
                  email: 'nuykeeh@gmail.com',
                  phone: '리부트오피스이메일'),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 56),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade700),
                      borderRadius: BorderRadius.circular(50)),
                ),
              )
            ]));
  }
}
