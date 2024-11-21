import 'package:flutter/material.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view/home/widget/card/business_card.dart';
import 'package:rebootOffice/view_model/see_more/see_more_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';
import 'package:rebootOffice/widget/modal/custom_two_button_modal.dart';

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
            const BusinessCard(
              name: '홍규진',
              nameEn: 'Hong Kyujin',
              department: '개발',
              email: 'hkj0206@dgu.ac.kr',
              phone: '010-5820-4625',
            ),
            const SizedBox(height: 20),
            _buildMenuButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButtons(BuildContext context) {
    return Column(children: [
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
      _buildMenuButton(
        title: '프로그램',
        onTap: () {
          // 프로그램 페이지로 이동
        },
      ),
      _buildMenuButton(
          title: '로그아웃',
          onTap: () => showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.5),
                builder: (context) => CustomTwoButtonModal(
                  title: "Your Title",
                  leftButtonText: "Cancel",
                  rightButtonText: "Confirm",
                  onLeftButtonTap: () {},
                  onRightButtonTap: () {},
                ),
              )),
      _buildMenuButton(
          title: '다시 시작하기',
          onTap: () => showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.5),
                builder: (context) => CustomTwoButtonModal(
                  title: "Your Title",
                  leftButtonText: "Cancel",
                  rightButtonText: "Confirm",
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
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
