import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/static/app_routes.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view_model/login/login_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';

class LoginScreen extends BaseScreen<LoginViewModel> {
  const LoginScreen({super.key});

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLogo(),
          _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Image.asset(
        'assets/images/logo.png',
        width: 400,
      ),
    );
  }

  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: () async {
        bool success = await viewModel.kakaoSignInAccount();
        if (success) {
          _showSnackBar(
            title: '로그인 성공',
            message: '다양한 서비스를 이용해보세요!',
            textColor: ColorSystem.white,
          );
          Get.offAndToNamed(Routes.ROOT);
        } else {
          _showSnackBar(
            title: '로그인 실패',
            message: '다시 시도해주세요.',
            textColor: ColorSystem.white,
          );
        }
      },
      child: Center(
        child: Image.asset(
          'assets/images/kakao_login.png',
          width: 250,
        ),
      ),
    );
  }

  void _showSnackBar({
    required String title,
    required String message,
    Color? textColor,
  }) {
    Get.snackbar(
      title,
      message,
      colorText: textColor ?? ColorSystem.white,
      snackPosition: SnackPosition.TOP,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      duration: const Duration(seconds: 2),
      backgroundColor: ColorSystem.blue.shade500,
    );
  }
}
