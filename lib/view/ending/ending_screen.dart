import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view_model/ending/ending_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_back_appbar.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';
import 'package:rebootOffice/widget/modal/custom_two_button_modal.dart';

class EndingScreen extends BaseScreen<EndingViewModel> {
  const EndingScreen({super.key});

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  bool get setBottomInnerSafeArea => true;

  @override
  Color? get screenBackgroundColor => Colors.white;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: DefaultBackAppBar(
          showBackButton: true,
          title: ' ',
          onBackPress: () => {Get.back()},
          centerTitle: true,
        ));
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        Expanded(child: Center(child: _buildPageView())),
      ],
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: viewModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildFirstPage(),
        _buildSecondPage(),
        _buildThirdPage(Get.context!),
      ],
    );
  }

  Widget _buildFirstPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/profile_npc.svg',
            width: 200,
          ),
          const SizedBox(
            height: 32,
          ),
          _buildTitle('${viewModel.homeViewModel.userState.name}님 수고하셨습니다!'),
          const SizedBox(height: 4),
          _buildLabel(
              '리부트 오피스와 함께한 여정이 여러분의 \n삶에 용기와 변화를 선물했길 바랍니다.\n앞으로도 응원하겠습니다. 감사합니다!'),
        ],
      ),
    );
  }

  Widget _buildSecondPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFF04B014),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/common/check_icon.svg'),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '22개',
                  style: FontSystem.KR48B.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          _buildTitle('미션을 수행하신 결과에요!'),
          const SizedBox(height: 4),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: '총 31일 동안 미션을 수행하셨고,\n그 중 ',
                  style: FontSystem.KR16R
                      .copyWith(color: ColorSystem.grey.shade700),
                ),
                TextSpan(
                    text: '22개를 완료',
                    style: FontSystem.KR16SB
                        .copyWith(color: ColorSystem.grey.shade700)),
                TextSpan(
                    text: '하셨습니다.',
                    style: FontSystem.KR16R
                        .copyWith(color: ColorSystem.grey.shade700)),
              ]))
        ],
      ),
    );
  }

  Widget _buildThirdPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.center, // Add this
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                // Wrap with Center
                child: SvgPicture.asset(
                  'assets/images/profile_npc.svg',
                  width: 200,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              _buildTitle('성실히 이행해 주셔서 감사합니다!'),
              const SizedBox(height: 4),
              _buildLabel('이제 앞으로의 여정은 전문 상담사와 함께\n상담을 통해 새로운 시작을 준비해 보세요!'),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: ColorSystem.blue.shade500,
                borderRadius: BorderRadius.circular(12),
              ),
              child: RoundedRectangleTextButton(
                text: '지원센터 바로가기',
                textStyle: FontSystem.KR16B.copyWith(color: ColorSystem.white),
                padding: const EdgeInsets.symmetric(vertical: 16),
                onPressed: () => showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.5),
                  builder: (context) => CustomTwoButtonModal(
                    title:
                        "${viewModel.homeViewModel.userState.name}님 이제 마지막 단계입니다",
                    label: '지금까지 달성한 미션을 확인하고,\n더 많은 도움은 지원센터에서 받아보세요!',
                    leftButtonText: "취소",
                    rightButtonText: "확인",
                    onLeftButtonTap: () {},
                    onRightButtonTap: () {},
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Column(
      children: [
        Text(
          text,
          style: FontSystem.KR24B,
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: FontSystem.KR16R.copyWith(color: ColorSystem.grey.shade700),
      textAlign: TextAlign.center,
    );
  }
}
