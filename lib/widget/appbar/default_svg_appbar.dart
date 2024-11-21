import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebootOffice/widget/button/custom_icon_button.dart';

class DefaultSvgAppBar extends StatelessWidget {
  const DefaultSvgAppBar({
    super.key,
    required this.svgPath,
    required this.height,
    this.actions = const <CustomIconButton>[],
    this.onBackPress,
    this.showBackButton = true, // 기본값을 true로 설정
  });

  final String svgPath;
  final double height;
  final List<CustomIconButton> actions;
  final Function()? onBackPress;
  final bool showBackButton;
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
      leading: showBackButton
          ? IconButton(
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              icon: SvgPicture.asset(
                "assets/icons/appbar/arrow_back_black.svg",
                width: 24,
                height: 24,
              ),
              onPressed: onBackPress,
            )
          : null,
    );
  }
}
