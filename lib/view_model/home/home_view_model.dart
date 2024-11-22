import 'package:get/get.dart';
import 'package:rebootOffice/model/home/daily_work_state.dart';
import 'package:rebootOffice/model/home/week_state.dart';
import 'package:rebootOffice/repository/home/home_repository.dart';

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
  /* ------------------------------------------------------ */
  /* ----------------- Public Fields ---------------------- */
  /* ------------------------------------------------------ */

  WeekState get weekState => _weekState.value;
  List<DailyWorkState> get dailyWorkState => _dailyWorkState;
  @override
  void onInit() {
    super.onInit();
    // Dependency Injection
    _homeRepository = Get.find<HomeRepository>();
    // Initialize private fields
    readWeek();
    readDailyWork();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  void readWeek() async {
    _weekState.value = await _homeRepository.readUserWeek();
  }

  void readDailyWork() async {
    _dailyWorkState.value = await _homeRepository.readUserDailyWork();
  }
}
