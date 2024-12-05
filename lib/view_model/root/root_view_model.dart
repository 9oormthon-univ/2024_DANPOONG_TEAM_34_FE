import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/model/root/custom_bottom_navigation_item_state.dart';
import 'package:rebootOffice/view_model/chatting_list/chatting_room_list_view_model.dart';
import 'package:rebootOffice/view_model/home/home_view_model.dart';
import 'package:rebootOffice/view_model/statistics/statistics_view_model.dart';
// import 'package:rebootOffice/repository/user/user_repository.dart';

class RootViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* ----------------- Static Fields ---------------------- */
  /* ------------------------------------------------------ */
  static const duration = Duration(milliseconds: 200);

  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */
  // late final UserRepository _userRepository;

  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final RxInt _selectedIndex;

  /* ------------------------------------------------------ */
  /* ----------------- Public Fields ---------------------- */
  /* ------------------------------------------------------ */
  late final List<CustomBottomNavigationItemState> bottomNavItems;

  int get selectedIndex => _selectedIndex.value;

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection

    // _userRepository = Get.find<UserRepository>();

    // Initialize private fields
    _selectedIndex = 0.obs;

    bottomNavItems = [
      CustomBottomNavigationItemState(
          src: "assets/rivs/bottom_navigation_bar_icons.riv",
          artBoard: "CROWN",
          stateMachineName: "CROWN_Interactivity"),
      CustomBottomNavigationItemState(
          src: "assets/rivs/bottom_navigation_bar_icons.riv",
          artBoard: "HOME",
          stateMachineName: "HOME_Interactivity"),
      CustomBottomNavigationItemState(
          src: "assets/rivs/bottom_navigation_bar_icons.riv",
          artBoard: "USER",
          stateMachineName: "USER_Interactivity"),
    ];
  }

  void showPopupForCurrentTab(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        Get.find<HomeViewModel>().showBusinessCardPopup(context);
        break;
      case 1:
        Get.find<ChattingRoomListViewModel>().showBusinessCardPopup(context);
        break;
      case 2:
        Get.find<StatisticsViewModel>().showBusinessCardPopup(context);
        break;
      // 필요한 경우 다른 탭에 대한 케이스 추가
    }
  }

  void fetchIndex(int index) {
    _selectedIndex.value = index;
  }
}
