import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view/home/home_screen.dart';
import 'package:rebootOffice/view/root/widget/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:rebootOffice/view_model/root/root_view_model.dart';

class RootScreen extends BaseScreen<RootViewModel> {
  const RootScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Obx(
      () => IndexedStack(
        index: viewModel.selectedIndex,
        children: const [
          // LoadMapScreen(),
          HomeScreen(), HomeScreen(), HomeScreen(), HomeScreen(), HomeScreen()

          // const ProfileScreen(),
        ],
      ),
    );
  }

  @override
  bool get extendBodyBehindAppBar => true;

  @override
  Widget buildBottomNavigationBar(BuildContext context) =>
      const CustomBottomNavigationBar();
}
