import 'package:flutter/material.dart';

class RoundedRectangleTextButton extends StatelessWidget {
  const RoundedRectangleTextButton({
    super.key,
    this.height = double.infinity,
    this.width = double.infinity,
    required this.text,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.backgroundColor,
    this.foregroundColor,
    this.borderSide,
    this.onPressed,
  });

  final double width;
  final double height;
  final String text;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderSide? borderSide;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        fixedSize: Size(width, height),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        side: borderSide,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: padding,
      ),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
