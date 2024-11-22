import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/widget/button/custom_icon_button.dart';

class DefaultWhiteBackAppBar extends StatelessWidget {
  const DefaultWhiteBackAppBar({
    super.key,
    required this.title,
    this.actions = const <CustomIconButton>[],
    this.onBackPress,
    this.showBackButton = true, // 기본값을 true로 설정
    this.centerTitle = false,
  });

  final String title;
  final List<CustomIconButton> actions;
  final Function()? onBackPress;
  final bool showBackButton;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(right: 16),
        child:
            Text(title, style: FontSystem.KR16M.copyWith(color: Colors.white)),
      ),
      centerTitle: centerTitle,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: true,
      titleSpacing: 0,
      leadingWidth: 50,
      leading: IconButton(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        icon: SvgPicture.asset(
          "assets/icons/appbar/arrow_back_white.svg",
          width: 24,
          height: 24,
        ),
        onPressed: onBackPress,
      ),
      actions: actions,
    );
  }
}
