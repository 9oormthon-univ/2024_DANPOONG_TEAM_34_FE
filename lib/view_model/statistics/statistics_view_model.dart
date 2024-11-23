import 'dart:core';

import 'package:get/get.dart';
import 'package:rebootOffice/model/statistics/attendance_state.dart';
import 'package:rebootOffice/model/statistics/period_state.dart';
import 'package:rebootOffice/repository/home/home_repository.dart';
import 'package:rebootOffice/repository/statistics/statistics_repository.dart';

class StatisticsViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */
  late final _statisticsRepository;
  late final _homeRepository;
  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final RxInt _selectedIndex = 0.obs;
  late final Rx<DateTime> _startDate = DateTime.now().obs;
  late final RxBool _isTouched = false.obs;
  late final RxString _userName = ''.obs;
  // 각 탭별 출석 데이터를 저장할 맵
  final RxList<AttendanceState> _attendanceState = RxList<AttendanceState>();
  final Rx<PeriodState> _periodState = PeriodState.initial().obs;

  /* ------------------------------------------------------ */
  /* ----------------- Public Fields ---------------------- */
  /* ------------------------------------------------------ */
  int get selectedIndex => _selectedIndex.value;
  DateTime get startDate => _startDate.value;
  bool get isTouched => _isTouched.value;
  PeriodState get periodState => _periodState.value;
  String get userName => _userName.value;

  List<AttendanceState> get attendanceState => _attendanceState.value;

  @override
  void onInit() async {
    super.onInit();
    // DI
    _statisticsRepository = Get.find<StatisticsRepository>();
    _homeRepository = Get.find<HomeRepository>();
    // Initialize private fields
    _attendanceState
        .addAll(List.generate(3, (index) => AttendanceState.empty()));
    // 사용자의 출석 데이터를 읽어옴
    readAttendanceList();

    // 출석 데이터 초기화
    readRemainPeriod();
    readUserName();
  }

  void setSelectedIndex(int index) {
    _selectedIndex.value = index;
  }

  void setIsTouched(bool value) {
    _isTouched.value = value;
  }

  void readRemainPeriod() async {
    // 남은 기간을 계산하는 로직
    _periodState.value = await _statisticsRepository.readUserPeriod();
  }

  void readAttendanceList() async {
    // 현재 출석 상태를 읽어오는 로직
    _attendanceState[0] = await _statisticsRepository.readUserAttendanceList(0);
    _attendanceState[1] = await _statisticsRepository.readUserAttendanceList(1);
    _attendanceState[2] = await _statisticsRepository.readUserAttendanceList(2);
  }

  void readUserName() async {
    // 사용자 이름을 읽어오는 로직
    final userState = await _homeRepository.readUserState();
    _userName.value = userState.name;
  }
}
