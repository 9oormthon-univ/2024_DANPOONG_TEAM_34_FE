import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';

class PopupOnboardingStatisticsModal extends StatefulWidget {
  const PopupOnboardingStatisticsModal({super.key});

  @override
  State<PopupOnboardingStatisticsModal> createState() =>
      _PopupOnboardingStatisticsModalState();
}

class _PopupOnboardingStatisticsModalState
    extends State<PopupOnboardingStatisticsModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            width: 350,
            height: 470,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildFirstPage(),
                ),
                _buildButton(),
              ],
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.close,
                color: ColorSystem.grey.shade800,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title, String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: FontSystem.KR20SB,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            label,
            style: FontSystem.KR14R.copyWith(color: ColorSystem.grey.shade600),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget _buildFirstPage() {
    return Column(
      children: [
        _buildTitle('통계를 확인 하세요!', '섹션별 미션 완료 여부를\n아이콘으로 확인해보세요.'),
        const SizedBox(
          height: 20,
        ),
        SvgPicture.asset(
          'assets/images/popup_statistics.svg',
          width: 270,
        )
      ],
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: ColorSystem.blue.shade500,
          borderRadius: BorderRadius.circular(16),
        ),
        child: RoundedRectangleTextButton(
          text: '이해했어요',
          textStyle: FontSystem.KR16SB.copyWith(
            color: ColorSystem.white,
            backgroundColor: ColorSystem.blue.shade500,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
    );
  }
}
