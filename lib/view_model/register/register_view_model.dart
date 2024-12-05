import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/app/firebase/local_fcm_service.dart';
import 'package:rebootOffice/repository/register/register_repository.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';
import 'package:rebootOffice/utility/static/app_routes.dart';

class RegisterViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */
  late final RegisterRepository _registerRepository;
  final LocalFcmNotificationService _notificationService =
      LocalFcmNotificationService();
  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final PageController _pageController;
  // 현재 페이지
  final RxInt _currentPageIndex = 0.obs;

  // 애니메이션 중인지 상태 관리
  final RxBool _isAnimating = true.obs;

  // 텍스트 데이터
  RxString displayText = '안녕하세요 \n인사팀 팀장 리부트 입니다'.obs;

  // 근무기간 선택 ("1주" 또는 "2주" 또는 "3주")
  final RxString _selectedWork = ''.obs;

  // 가능 업무 영역(외근) 선택
  final RxString _selectedWorkPlace = ''.obs;

  // 가능 업무 영역(식사) 선택
  final RxList<String> selectedItems = <String>[].obs;

  final List<String> options = [
    "아침 (09:00 ~ 10:00)",
    "점심 (12:00 ~ 13:00)",
    "저녁 (18:00 ~ 19:00)",
  ];

  // 시간 컨트롤러
  final RxInt _selectedHours = 6.obs;
  final RxInt _selectedMinutes = 0.obs;

  // 시간 선택
  Rx<DateTime> selectedTimeHours = DateTime(2024, 1, 1, 7, 0).obs;
  Rx<DateTime> selectedTimeMinutes = DateTime(2024, 1, 1, 0, 0).obs;

  RxBool isChangeHours = false.obs;

  // /* ------------------------------------------------------ */
  // /* ----------------- Public Fields ---------------------- */
  // /* ------------------------------------------------------ */
  PageController get pageController => _pageController;

  int get currentPageIndex => _currentPageIndex.value;
  set currentPageIndex(int value) => _currentPageIndex.value = value;

  bool get isAnimating => _isAnimating.value;

  // 주간 선택
  String? get selectedWork =>
      _selectedWork.value.isEmpty ? null : _selectedWork.value;

  bool get isSelectWork => _selectedWork.value.isEmpty ? false : true;

  // 외근 가능 여부 선택
  String? get selectedWorkPlace =>
      _selectedWorkPlace.value.isEmpty ? null : _selectedWorkPlace.value;

  bool get isSelectWorkPlace => _selectedWorkPlace.value.isEmpty ? false : true;

  // 시간 선택
  int get selectedHours => _selectedHours.value;
  int get selectedMinutes => _selectedMinutes.value;

  String getSelectedTime() {
    return '${_selectedHours.value.toString().padLeft(2, '0')}:${_selectedMinutes.value.toString().padLeft(2, '0')}';
  }

  // String getSelectedTime() {
  //   return '${selectedTimeHours.value.hour.toString().padLeft(2, '0')}:${selectedTimeMinutes.value.minute.toString().padLeft(2, '0')}';
  // }

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection
    _registerRepository = Get.find<RegisterRepository>();
    // 페이지 컨트롤러 초기화
    _pageController = PageController(viewportFraction: 1);
    if (currentPageIndex == 0) {
      startTextChange(); // 페이지 1에서만 애니메이션 시작
    }

    _initNotifications();
  }

  // FCM 초기화 메서드
  Future<void> _initNotifications() async {
    await _notificationService.initNotification();
  }

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }

  // 근무 선택 함수
  void selectWork(String work) {
    _selectedWork.value = work;
  }

  void selectWorkPlace(String work) {
    _selectedWorkPlace.value = work;
  }

  void updateSelectedHours(DateTime newTime) {
    selectedTimeHours.value = newTime;
  }

  void updateSelectedMinutes(DateTime updatedTime) {
    selectedTimeMinutes.value = updatedTime;
  }

  // 시간 선택
  void updateSelectedHour(int hour) {
    _selectedHours.value = hour;
  }

  void updateSelectedMinute(int minute) {
    _selectedMinutes.value = minute;
  }

  /// 다음 페이지로 이동
  void goToNextStep() {
    try {
      if (_currentPageIndex.value < 5) {
        if (_pageController.hasClients) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          _currentPageIndex.value++;
        } else {
          // 연결되지 않았을 때 처리 (예: 로깅 또는 디버그 메시지)
          debugPrint('PageController가 PageView와 연결되지 않았습니다.');
        }
      }
    } catch (e) {
      print("Error in goToNextStep: $e");
    }
  }

  // 텍스트 변경을 시작하는 함수
  void startTextChange() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      // 텍스트 변경 로직
      if (displayText.value == '안녕하세요 \n인사팀 팀장 리부트 입니다') {
        displayText.value = '지금부터 근로계약서를\n작성 하겠습니다';
      } else if (displayText.value == '지금부터 근로계약서를\n작성 하겠습니다') {
        displayText.value = '근로계약서는\n앞으로 주어질 업무를 결정 합니다';
      } else if (displayText.value == '근로계약서는\n앞으로 주어질 업무를 결정 합니다') {
        displayText.value = '신중하게 작성 해주세요!';
        _isAnimating.value = false;
        timer.cancel(); // 마지막 텍스트 변경 후 타이머 종료
      }
    });
  }

  // 식사 시간 매핑
  final Map<String, String> mealTimeMap = {
    "아침 (09:00 ~ 10:00)": "MORNING",
    "점심 (12:00 ~ 13:00)": "LUNCH",
    "저녁 (18:00 ~ 19:00)": "DINNER"
  };

  // POST 요청을 위한 데이터 생성
  Map<String, dynamic> createCommonData() {
    // 선택된 근무 주차 변환 (1주, 2주, 3주 -> 1, 2, 3)
    int partTime = int.parse(_selectedWork.value.replaceAll('주', '')) * 7;
    // 출근 시간 포맷팅 (HH:mm:ss)
    // String attendanceTime =
    //     "${selectedTimeHours.value.hour.toString().padLeft(2, '0')}:"
    //     "${selectedTimeMinutes.value.minute.toString().padLeft(2, '0')}:00";
    String attendanceTime =
        "${_selectedHours.value.toString().padLeft(2, '0')}:"
        "${_selectedMinutes.value.toString().padLeft(2, '0')}:00";

    final now = DateTime.now();
    DateTime workStartTime = DateTime(
      now.year,
      now.month,
      now.day,
      // selectedTimeHours.value.hour,
      // selectedTimeMinutes.value.minute,
      selectedHours,
      selectedMinutes,
    );
    String workStartTimeString = workStartTime.year.toString() +
        '-' +
        workStartTime.month.toString().padLeft(2, '0') +
        "-" +
        workStartTime.day.toString().padLeft(2, '0');

    // 선택된 식사 시간 변환
    List<Map<String, String>> mealTimeList = selectedItems.map((item) {
      return {"mealTime": mealTimeMap[item] ?? ""};
    }).toList();

    // 외근 여부
    bool isOutside = _selectedWorkPlace.value == '네, 외근에 도전해보겠습니다!';
    // LogUtil.info({
    //   "partTime": partTime,
    //   "attendanceTime": attendanceTime,
    //   "workStartTime": workStartTimeString,
    //   "mealTimeList": mealTimeList,
    //   "isOutside": isOutside
    // });
    return {
      "partTime": partTime,
      "attendanceTime": attendanceTime,
      "workStartTime": workStartTimeString,
      "mealTimeList": mealTimeList,
      "isOutside": isOutside
    };
  }

  Map<String, dynamic> createPostData() {
    var data = createCommonData();
    data.remove('workStartTime'); // POST 요청에서 workStartTime 제거

    LogUtil.info(data);

    return data;
  }

  Map<String, dynamic> createFcmData() {
    return createCommonData(); // FCM용 데이터는 workStartTime 포함
  }

  Future<void> submitRegisterData() async {
    LogUtil.debug('submitRegisterData 시작');
    try {
      final Map<String, dynamic> registerData = createPostData();
      final Map<String, dynamic> fcmData = createFcmData();

      // LOCAL-FCM 알림 설정
      await _notificationService.scheduleNotifications(
        partTime: fcmData['partTime'],
        attendanceTime: fcmData['attendanceTime'],
        workStartTime: fcmData['workStartTime'],
        mealTimeList: List<Map<String, String>>.from(fcmData['mealTimeList']),
        isOutside: fcmData['isOutside'],
      );

      final response = await _registerRepository.sendRegisterData(registerData);

      // 서버로 보내는 페이로드 로그 찍기
      LogUtil.info('Sending payload to server: $response');

      if (response.isOk) {
        // 성공 처리
        Get.snackbar('성공', '근로계약서가 성공적으로 제출되었습니다.');
        LogUtil.debug('성공 스낵바 표시');
      } else {
        // 실패 처리
        Get.snackbar('오류', '근로계약서 제출에 실패했습니다.');
        LogUtil.debug('오류');
      }
    } catch (e) {
      LogUtil.error('Error submitting register data: $e');
      Get.snackbar('오류', '근로계약서 제출 중 오류가 발생했습니다.');
    }
    LogUtil.debug('submitRegisterData 종료');
  }
}
