import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view/home/widget/home_business_card.dart';
import 'package:rebootOffice/view_model/see_more/see_more_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';
import 'package:rebootOffice/widget/modal/custom_two_button_modal.dart';

import '../../repository/auth/auth_repository.dart';

class SeeMoreScreen extends BaseScreen<SeeMoreViewModel> {
  const SeeMoreScreen({super.key});
  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  bool get setBottomInnerSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: DefaultSvgAppBar(
        svgPath: 'assets/icons/appbar/header-logo.svg',
        height: 15,
        showBackButton: false,
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeBusinessCard(),
            const SizedBox(height: 20),
            _buildMenuButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButtons(BuildContext context) {
    final authRepository = Get.find<AuthRepository>();

    return Column(children: [
      _buildMenuButton(
        title: '알림 설정',
        onTap: () {
          // 알림 설정 페이지로 이동
        },
      ),
      _buildMenuButton(
        title: '서비스 이용 약관',
        onTap: () {
          // 서비스 이용 약관 페이지로 이동
        },
      ),
      _buildMenuButton(
        title: '개인정보처리방침',
        onTap: () {
          // 개인정보처리방침 페이지로 이동
        },
      ),
      _buildMenuButton(
        title: '고객센터',
        onTap: () {
          // 고객센터 페이지로 이동
        },
      ),
      // _buildMenuButton(
      //   title: '프로그램',
      //   onTap: () {
      //     // 프로그램 페이지로 이동
      //   },
      // ),
      _buildMenuButton(
          title: '로그아웃', onTap: () => authRepository.clearTokens()),
      _buildMenuButton(
          title: '회원탈퇴',
          onTap: () => showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.5),
                builder: (context) => CustomTwoButtonModal(
                  title: "회원 탈퇴 안내",
                  label:
                      "회원 탈퇴 시, 지금까지 수행한 모든\n업무 기록과 데이터가 영구적으로 삭제됩니다.\n삭제된 내용은 복구할 수 없습니다.\n탈퇴를 진행하시려면 확인 버튼을 눌러주세요",
                  leftButtonText: "취소",
                  rightButtonText: "확인",
                  onLeftButtonTap: () {},
                  onRightButtonTap: () {},
                ),
              )),
    ]);
  }

  Widget _buildMenuButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: FontSystem.KR16R,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
