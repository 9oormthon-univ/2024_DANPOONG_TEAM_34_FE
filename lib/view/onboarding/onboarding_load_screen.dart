import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
    return Stack(
      children: [
        _buildAnimatedBackground(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Icon(
                  Icons.circle,
                  color: ColorSystem.grey.shade600,
                  size: 8,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "제출하신 이력서를 검토하고 있습니다…",
                  style:
                      TextStyle(fontSize: 18, color: ColorSystem.grey.shade600),
                )
              ]),
              const SizedBox(
                height: 36,
              ),
              Row(children: [
                Icon(
                  Icons.circle,
                  color: ColorSystem.grey.shade600,
                  size: 8,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "지원자의 역량을 분석하고 있습니다…",
                  style:
                      TextStyle(fontSize: 18, color: ColorSystem.grey.shade600),
                )
              ]),
              const SizedBox(
                height: 36,
              ),
              Row(children: [
                Icon(
                  Icons.circle,
                  color: ColorSystem.grey.shade600,
                  size: 8,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "최종 회의를 통해 결정 중입니다…",
                  style:
                      TextStyle(fontSize: 18, color: ColorSystem.grey.shade600),
                )
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedBackground() {
    // return AnimatedBuilder(
    //   animation: viewModel.isTextChanged,
    //   builder: (context, child) {
    return CustomPaint(
      painter: CirclePainter(),
      child: Container(),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = ColorSystem.white.withOpacity(.2)
      ..style = PaintingStyle.fill;

    double radius =
        50.0 + 20 * (DateTime.now().second % 10); // 간단한 애니메이션을 위해 초에 따라 변화
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
