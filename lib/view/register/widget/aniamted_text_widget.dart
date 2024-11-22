import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedTextWidget extends StatelessWidget {
  final String text;

  const AnimatedTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Text(
        text,
        key: ValueKey<String>(text),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, color: Color(0xFF111111)),
      ),
    );
  }
}
