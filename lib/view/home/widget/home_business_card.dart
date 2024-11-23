import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_widget.dart';
import 'package:rebootOffice/view_model/home/home_view_model.dart';

class HomeBusinessCard extends BaseWidget<HomeViewModel> {
  const HomeBusinessCard({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () => viewModel.toggleBusinessCard(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: Get.width * 0.9,
            height: viewModel.isBusinessCardExpanded ? 200 : 87,
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: ColorSystem.blue.shade500,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: ColorSystem.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      if (viewModel.isBusinessCardExpanded &&
                          viewModel.showBottomInfo) ...[
                        const Spacer(),
                        _buildContactInfo(),
                      ],
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: _buildLogo(),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(viewModel.userState.name,
                style: FontSystem.MKR14B.copyWith(color: ColorSystem.white)),
            const SizedBox(width: 8),
            Text(viewModel.userState.nameEn,
                style: FontSystem.MKR12R.copyWith(color: ColorSystem.white))
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              "리부트오피스 일상회복팀 | ",
              style: FontSystem.MKR12R.copyWith(color: ColorSystem.white),
            ),
            Text(
              '행복',
              style: FontSystem.MKR12R.copyWith(color: ColorSystem.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          viewModel.userState.email,
          style: FontSystem.MKR10R.copyWith(color: ColorSystem.white),
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset(
      'assets/icons/common/app-logo.svg',
      width: 30,
      height: 30,
      colorFilter: const ColorFilter.mode(
        Colors.white,
        BlendMode.srcIn,
      ),
    );
  }
}
