import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';

/**
 * 사용 예시
 showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) => CustomTwoButtonModal(
    title: "Your Title",
    leftButtonText: "Cancel",
    rightButtonText: "Confirm",
    onLeftButtonTap: () {},
    onRightButtonTap: () {},
    ),
    );
    @author 홍규진
 */
class CustomTwoButtonModal extends StatelessWidget {
  final String title;
  final String label;
  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback onLeftButtonTap;
  final VoidCallback onRightButtonTap;

  const CustomTwoButtonModal({
    super.key,
    required this.title,
    required this.leftButtonText,
    required this.rightButtonText,
    required this.onLeftButtonTap,
    required this.onRightButtonTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: FontSystem.KR16B,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                label,
                style:
                    FontSystem.KR14R.copyWith(color: ColorSystem.grey.shade600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: onLeftButtonTap,
            style: TextButton.styleFrom(
              backgroundColor: ColorSystem.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              leftButtonText,
              style: FontSystem.KR14M.copyWith(
                color: ColorSystem.grey.shade600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextButton(
            onPressed: onRightButtonTap,
            style: TextButton.styleFrom(
              backgroundColor: ColorSystem.blue.shade500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              rightButtonText,
              style: FontSystem.KR14M.copyWith(
                color: ColorSystem.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
