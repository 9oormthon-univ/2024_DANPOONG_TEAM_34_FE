import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.assetPath,
    required this.onPressed,
    this.colorFilter,
  });

  final String assetPath;
  final Function() onPressed;
  final ColorFilter? colorFilter;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      icon: SvgPicture.asset(
        assetPath,
        width: 32,
        height: 32,
        colorFilter: colorFilter,
      ),
      onPressed: onPressed,
    );
  }
}
