import 'package:get/get.dart';
import 'package:rebootOffice/model/root/custom_bottom_navigation_item_state.dart';
import 'package:rebootOffice/model/root/user_state.dart';
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
  late final Rx<UserState> _userState;

  /* ------------------------------------------------------ */
  /* ----------------- Public Fields ---------------------- */
  /* ------------------------------------------------------ */
  late final List<CustomBottomNavigationItemState> bottomNavItems;

  int get selectedIndex => _selectedIndex.value;
  UserState get userState => _userState.value;

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection

    // _userRepository = Get.find<UserRepository>();

    // Initialize private fields
    _selectedIndex = 1.obs;
    _userState = UserState.initial().obs;

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

  @override
  void onReady() async {
    super.onReady();

    // await _userRepository.readUserState().then((value) {
    //   _userState.value = value;
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchIndex(int index) {
    _selectedIndex.value = index;
  }

  void updateEnvironmentalTemperature() {
    // 0.1 증가시키기
    _userState.value = _userState.value.copyWith(
      environmentalTemperature:
          (double.parse(_userState.value.environmentalTemperature) + 0.1)
              .toString(),
    );
  }

  void onIsAlarmSwitch() async {
    _userState.value = _userState.value
        .copyWith(isActiveNotification: !_userState.value.isActiveNotification);

    // await _userRepository
    //     .updateUserNotificationActive(_userState.value.isActiveNotification);
  }

  void changeAlarmTime(int hour, int minute) async {
    _userState.value = _userState.value.copyWith(
      notificationHour: hour,
      notificationMinute: minute,
    );

    // await _userRepository.updateUserNotificationTime(hour, minute);
  }
}
