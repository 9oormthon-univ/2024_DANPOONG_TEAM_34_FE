import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_widget.dart';

import '../../../../view_model/root/root_view_model.dart';
import 'component/custom_bottom_navigation_item.dart';

class CustomBottomNavigationBar extends BaseWidget<RootViewModel> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () => Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: ColorSystem.grey.withOpacity(0.3),
                offset: const Offset(0, -2),
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomNavigationBar(
            // State Management
            currentIndex: viewModel.selectedIndex,
            onTap: viewModel.fetchIndex,

            // Design
            backgroundColor: ColorSystem.white,
            type: BottomNavigationBarType.fixed,

            // When not selected
            unselectedItemColor: const Color(0xFF767676),
            unselectedLabelStyle: FontSystem.KR12R,

            // When selected
            selectedItemColor: const Color(0xFF111111),
            selectedLabelStyle: FontSystem.KR12R,

            // Items
            items: [
              BottomNavigationBarItem(
                icon: CustomBottomNavigationItem(
                  isActive: viewModel.selectedIndex == 0,
                  assetPath: "assets/icons/bottom_navigation/home.svg",
                ),
                label: "홈",
              ),
              BottomNavigationBarItem(
                icon: CustomBottomNavigationItem(
                  isActive: viewModel.selectedIndex == 1,
                  assetPath: "assets/icons/bottom_navigation/chatting.svg",
                ),
                label: "채팅",
              ),
              BottomNavigationBarItem(
                icon: CustomBottomNavigationItem(
                  isActive: viewModel.selectedIndex == 2,
                  assetPath: "assets/icons/bottom_navigation/statistic.svg",
                ),
                label: "통계",
              ),
              BottomNavigationBarItem(
                icon: CustomBottomNavigationItem(
                  isActive: viewModel.selectedIndex == 3,
                  assetPath: "assets/icons/bottom_navigation/see_more.svg",
                ),
                label: "더보기",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
