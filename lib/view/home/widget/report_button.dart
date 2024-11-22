import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';

class ReportButton extends StatelessWidget {
  final VoidCallback onTap;

  const ReportButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedRectangleTextButton(
      onPressed: onTap,
      width: Get.width,
      backgroundColor: ColorSystem.blue.shade500,
      padding: const EdgeInsets.symmetric(vertical: 18),
      text: '업무일지 보러가기',
      textStyle: FontSystem.KR16B.copyWith(color: ColorSystem.white),
    );
  }
}
