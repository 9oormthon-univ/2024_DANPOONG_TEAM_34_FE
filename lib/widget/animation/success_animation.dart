import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessAnimation extends StatelessWidget {
  const SuccessAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animation/success_animation4.json',
        width: 400,
        height: 400,
        repeat: false,
      ),
    );
  }
}
