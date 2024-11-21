import 'package:flutter/widgets.dart';
import 'package:rebootOffice/utility/system/font_system.dart';

class OnboardingLabel extends StatelessWidget {
  const OnboardingLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: FontSystem.KR14R,
    );
  }
}
