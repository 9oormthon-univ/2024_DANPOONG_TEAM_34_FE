import 'package:flutter/widgets.dart';
import 'package:rebootOffice/utility/system/font_system.dart';

class OnboardingTitle extends StatelessWidget {
  const OnboardingTitle({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title, style: FontSystem.KR28B);
  }
}
