import 'package:flutter/material.dart';

/// InfinityLine
///
/// Color and height can be set.
///
/// It is used to create a line that stretches infinitely.
class InfinityVerticalLine extends StatelessWidget {
  const InfinityVerticalLine({
    super.key,
    required this.width,
    this.color,
  });

  final Color? color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: double.infinity,
      color: color,
    );
  }
}
