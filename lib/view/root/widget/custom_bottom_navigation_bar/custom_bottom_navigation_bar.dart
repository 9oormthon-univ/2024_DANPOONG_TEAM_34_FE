import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/view/base/base_widget.dart';

import '../../../../view_model/root/root_view_model.dart';
import 'component/custom_bottom_navigation_item.dart';

class CustomBottomNavigationBar extends BaseWidget<RootViewModel> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Container(
      height: 88,
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: GetPlatform.isAndroid ? 20 : 32,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: _buildItemViews(),
      ),
    );
  }

  List<Widget> _buildItemViews() {
    List<String> inActiveAssetPath = [
      "assets/icons/bottom_navigation/home-icon.svg",
      "assets/icons/bottom_navigation/chatting-icon.svg",
      "assets/icons/bottom_navigation/statistics-icon.svg",
      "assets/icons/bottom_navigation/etc-icon.svg",
    ];

    List<String> activeAssetPath = [
      "assets/icons/bottom_navigation/home-active-icon.svg",
      "assets/icons/bottom_navigation/chatting-active-icon.svg",
      "assets/icons/bottom_navigation/statistics-active-icon.svg",
      "assets/icons/bottom_navigation/etc-active-icon.svg",
    ];

    return List.generate(
      4,
      (index) => Expanded(
        child: GestureDetector(
          onTap: () => {
            viewModel.fetchIndex(index),
          },
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () {
                    bool isActive = viewModel.selectedIndex == index;
                    String assetPath = isActive
                        ? activeAssetPath[index]
                        : inActiveAssetPath[index];
                    return CustomBottomNavigationItem(
                      isActive: isActive,
                      assetPath: assetPath,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
