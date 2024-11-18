import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebootOffice/widget/button/custom_icon_button.dart';

class DefaultSvgAppBar extends StatelessWidget {
  const DefaultSvgAppBar({
    super.key,
    required this.svgPath,
    required this.height,
    this.actions = const <CustomIconButton>[],
  });

  final String svgPath;
  final double height;
  final List<CustomIconButton> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset(
        svgPath,
        height: height,
      ),
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      actions: actions,
    );
  }
}
