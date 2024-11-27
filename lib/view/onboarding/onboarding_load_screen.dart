import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view_model/onboarding/onboarding_view_model.dart';

class OnboardingLoadScreen extends BaseScreen<OnboardingViewModel> {
  const OnboardingLoadScreen({super.key});

  @override
  bool get wrapWithInnerSafeArea => false;

  @override
  bool get setBottomInnerSafeArea => false;

  @override
  Color? get screenBackgroundColor => ColorSystem.blue.shade500;

  @override
  Color? get unSafeAreaColor => ColorSystem.blue.shade500;

  @override
  Widget buildBody(BuildContext context) {
    Future.delayed(Duration.zero, () => viewModel.startAnimation());
    return Stack(
      children: [
        _buildLoadingBackground(),
        _buildLoadingText(),
      ],
    );
  }

  Widget _buildLoadingBackground() {
    return Center(
      child: OverflowBox(
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        child: Lottie.asset(
          'assets/animation/load_animation.json',
          width: 600, // 원래 크기 유지
          height: 600,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLoadingText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStepText(viewModel.steps[0], Icons.circle,
                  viewModel.steps[0] == viewModel.updatedSteps[0]),
              const SizedBox(
                height: 36,
              ),
              _buildStepText(viewModel.steps[1], Icons.circle,
                  viewModel.steps[1] == viewModel.updatedSteps[1]),
              const SizedBox(
                height: 36,
              ),
              _buildStepText(viewModel.steps[2], Icons.circle,
                  viewModel.steps[2] == viewModel.updatedSteps[2]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepText(String text, IconData icon, bool isActive) {
    return Row(
      children: [
        isActive
            ? SvgPicture.asset('assets/icons/common/check.svg')
            : Icon(
                icon,
                color: ColorSystem.grey.shade600,
                size: 8,
              ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: isActive ? Colors.white : ColorSystem.grey.shade600,
          ),
        ),
      ],
    );
  }
}
