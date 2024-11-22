import 'dart:core';

import 'package:get/get.dart';
import 'package:rebootOffice/model/statistics/attendance_state.dart';
import 'package:rebootOffice/model/statistics/period_state.dart';
import 'package:rebootOffice/repository/statistics/statistics_repository.dart';

class StatisticsViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */
  late final _statisticsRepository;
  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final RxInt _selectedIndex = 0.obs;
  late final Rx<DateTime> _startDate = DateTime.now().obs;
  late final RxInt _totalDays;
  late final RxBool _isTouched = false.obs;
  // 각 탭별 출석 데이터를 저장할 맵
  final RxMap<int, List<AttendanceState>> _attendanceState =
      RxMap<int, List<AttendanceState>>();
  final Rx<PeriodState> _periodState = PeriodState.initial().obs;

  /* ------------------------------------------------------ */
  /* ----------------- Public Fields ---------------------- */
  /* ------------------------------------------------------ */
  int get selectedIndex => _selectedIndex.value;
  DateTime get startDate => _startDate.value;
  int get totalDays => _totalDays.value;
  bool get isTouched => _isTouched.value;
  PeriodState get periodState => _periodState.value;
  Map<int, List<AttendanceState>> get attendanceState => _attendanceState;

  @override
  void onInit() async {
    super.onInit();
    _statisticsRepository = Get.find<StatisticsRepository>();
    // Initialize private fields
    _totalDays = 16.obs; // 예시로 16일로 설정

    // 출석 데이터 초기화
    readRemainPeriod();

    _initMockData();
  }

  //출석 여부 데이터 값 초기화
  void _initMockData() {
    //
    List<AttendanceState> data = [];

    for (int i = 0; i < _totalDays.value; i++) {
      final date = _startDate.value.add(Duration(days: i));
      data.add(AttendanceState(
        date: date,
        status: _getMockStatus(i),
      ));
    }

    _attendanceState[0] = data;
    _attendanceState[1] = data;
    _attendanceState[2] = data;
  }

  AttendanceStatus _getMockStatus(int dayIndex) {
    if (dayIndex < 2) return AttendanceStatus.complete;
    if (dayIndex == 2) return AttendanceStatus.warning;
    if (dayIndex == 4) return AttendanceStatus.absent;
    return AttendanceStatus.upcoming;
  }

  void setSelectedIndex(int index) {
    _selectedIndex.value = index;
  }

  void setIsTouched(bool value) {
    _isTouched.value = value;
  }

  List<AttendanceState> getCurrentAttendanceState() {
    return _attendanceState[selectedIndex] ?? [];
  }

  void readRemainPeriod() async {
    // 남은 기간을 계산하는 로직
    _periodState.value = await _statisticsRepository.readUserPeriod();
  }
}
