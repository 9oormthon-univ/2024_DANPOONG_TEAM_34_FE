import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view_model/onboarding/onboarding_view_model.dart';

class OnboardingLoadScreen extends BaseScreen<OnboardingViewModel> {
  const OnboardingLoadScreen({super.key});

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  bool get setBottomInnerSafeArea => true;

  @override
  Color? get screenBackgroundColor => const Color(0xFF0B1432);

  @override
  Widget buildBody(BuildContext context) {
    return Stack(
      children: [
        _buildAnimatedBackground(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Icon(
                  Icons.circle,
                  color: Color(0xFF999999),
                  size: 8,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "제출하신 이력서를 검토하고 있습니다…",
                  style: TextStyle(fontSize: 18, color: Color(0xFF999999)),
                )
              ]),
              SizedBox(
                height: 36,
              ),
              Row(children: [
                Icon(
                  Icons.circle,
                  color: Color(0xFF999999),
                  size: 8,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "지원자의 역량을 분석하고 있습니다…",
                  style: TextStyle(fontSize: 18, color: Color(0xFF999999)),
                )
              ]),
              SizedBox(
                height: 36,
              ),
              Row(children: [
                Icon(
                  Icons.circle,
                  color: Color(0xFF999999),
                  size: 8,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "최종 회의를 통해 결정 중입니다…",
                  style: TextStyle(fontSize: 18, color: Color(0xFF999999)),
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
      ..color = const Color(0xFF082B6A)
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
