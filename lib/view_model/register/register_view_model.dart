import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */

  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final PageController _pageController;
  // 현재 페이지
  final RxInt _currentPageIndex = 0.obs;

  // 애니메이션 중인지 상태 관리
  final RxBool _isAnimating = true.obs;

  // 텍스트 데이터
  RxString displayText = '안녕하세요 희균님!\n인사팀 팀장 리부트 입니다'.obs;

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

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection

    // 페이지 컨트롤러 초기화
    _pageController = PageController(viewportFraction: 1);
    if (currentPageIndex == 0) {
      startTextChange(); // 페이지 1에서만 애니메이션 시작
    }
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
      if (displayText.value == '안녕하세요 희균님!\n인사팀 팀장 리부트 입니다') {
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
}
