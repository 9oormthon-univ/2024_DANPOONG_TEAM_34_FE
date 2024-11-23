import 'package:get/get.dart';
import 'package:rebootOffice/model/home/daily_work_state.dart';
import 'package:rebootOffice/model/home/user_state.dart';
import 'package:rebootOffice/model/home/week_state.dart';
import 'package:rebootOffice/repository/home/home_repository.dart';
import 'package:rebootOffice/utility/functions/home_alrert_util.dart';

class HomeViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */
  late final _homeRepository;
  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final Rx<WeekState> _weekState = WeekState.initial().obs;
  late final RxList<DailyWorkState> _dailyWorkState = <DailyWorkState>[].obs;
  late final Rx<UserState> _userState = UserState.initial().obs;
  late final _isBusinessCardExpanded = false.obs;
  late final _showBottomInfo = false.obs;
  final RxBool _showWelcomeCard = false.obs;

  /* ------------------------------------------------------ */
  /* ----------------- Public Fields ---------------------- */
  /* ------------------------------------------------------ */

  WeekState get weekState => _weekState.value;
  List<DailyWorkState> get dailyWorkState => _dailyWorkState;
  UserState get userState => _userState.value;

  bool get isBusinessCardExpanded => _isBusinessCardExpanded.value;
  bool get showBottomInfo => _showBottomInfo.value;
  bool get showWelcomeCard => _showWelcomeCard.value;

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection
    _homeRepository = Get.find<HomeRepository>();
    // Initialize private fields
    readWeek();
    readDailyWork();
    readUserState();
    checkUnreadMessage();
  }

  void toggleBusinessCard() {
    if (_isBusinessCardExpanded.value) {
      _isBusinessCardExpanded.value = false;
      Future.delayed(const Duration(milliseconds: 240), () {
        _showBottomInfo.value = false;
      });
    } else {
      _isBusinessCardExpanded.value = true;
      Future.delayed(const Duration(milliseconds: 300), () {
        _showBottomInfo.value = true;
      });
    }
  }

  void readWeek() async {
    _weekState.value = await _homeRepository.readUserWeek();
  }

  void readDailyWork() async {
    _dailyWorkState.value = await _homeRepository.readUserDailyWork();
  }

  void readUserState() async {
    _userState.value = await _homeRepository.readUserState();
  }

  void checkUnreadMessage() async {
    _showWelcomeCard.value = await SharedPrefsUtil.getHasUnreadMessage();
  }
}
