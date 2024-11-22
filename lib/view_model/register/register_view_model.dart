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

  // 현재 텍스트 애니메이션 인덱스
  final RxInt _currentTextIndex = 0.obs;

  // 애니메이션 중인지 상태 관리
  final RxBool _isAnimating = false.obs;

  // 텍스트 데이터
  final List<String> _pageTexts = [
    '안녕하세요 희균님!\n인사팀 팀장 리부트 입니다',
    '지금부터 근로계약서를\n작성 하겠습니다',
    '근로계약서는\n앞으로 주어질 업무를 결정 합니다',
    '신중하게 작성 해주세요!'
  ];

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
  var selectedHour = 6.obs;
  var selectedMinute = 00.obs;

  // /* ------------------------------------------------------ */
  // /* ----------------- Public Fields ---------------------- */
  // /* ------------------------------------------------------ */
  PageController get pageController => _pageController;

  int get currentPageIndex => _currentPageIndex.value;
  set currentPageIndex(int value) => _currentPageIndex.value = value;

  int get currentTextIndex => _currentTextIndex.value < currentTexts.length
      ? _currentTextIndex.value
      : 0;

  bool get isAnimating => _isAnimating.value;

  List<String> get currentTexts => _pageTexts;

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
    // if (currentPageIndex == 0) {
    //   startTextAnimation(); // 페이지 1에서만 애니메이션 시작
    // }
  }

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }

  /// 텍스트 애니메이션 시작
  void startTextAnimation() async {
    _isAnimating.value = true;
    for (var i = 0; i < _pageTexts.length; i++) {
      _currentTextIndex.value = i;
      await Future.delayed(const Duration(seconds: 2));
    }
    _isAnimating.value = false; // 애니메이션 종료
  }

  // 근무 선택 함수
  void selectWork(String work) {
    _selectedWork.value = work;
  }

  void selectWorkPlace(String work) {
    _selectedWorkPlace.value = work;
  }

  // 시간 선택 함수
  void updateHour(int hour) {
    selectedHour.value = hour;
  }

  void updateMinute(int minute) {
    selectedMinute.value = minute;
  }

  /// 다음 페이지로 이동
  void goToNextStep() {
    try {
      if (_currentPageIndex.value < 3) {
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
  // void goToNextPage() async {
  //   if (_isAnimating.value) {
  //     return; // 애니메이션 중에는 페이지를 넘기지 않음
  //   }

  //   if (_currentPage.value < 3) {
  //     _currentPage.value++;
  //     _currentTextIndex.value = 0; // 텍스트 인덱스 초기화
  //     if (_currentPage.value == 0) {
  //       startTextAnimation(); // 페이지 1에서만 애니메이션 시작
  //     }
  //     await _pageController.nextPage(
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );

  //     // PageController가 업데이트된 후 currentPage와 동기화
  //     update();
  //   }
  // }
}
