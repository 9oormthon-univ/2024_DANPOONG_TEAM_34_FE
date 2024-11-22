import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:get/get.dart';

import '../../view/onboarding/onboarding_result_screen.dart';

class OnboardingViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */

  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final PageController _pageController;

  late final FlipCardController _flipCardController;

  // 사용자의 이름
  final RxString _name = ''.obs;
  // 현재 입력된 이름이 유효한지 상태 관리
  final RxBool _isNameValid = false.obs;

  // 사용자의 생년월일
  final RxString _birth = ''.obs;
  // 현재 입력된 생년월일 유효한지 상태 관리
  final RxBool _isBirthValid = false.obs;

  // 사용자의 자기소개
  final RxString _motivate = ''.obs;
  // 현재 입력된 자기소개가 유효한지 상태 관리
  final RxBool _isMotivateValid = false.obs;

  // 현재 선택된 성별 (null: 선택 안됨, "남성" 또는 "여성")
  final RxString _selectedGender = ''.obs;

  // 현재 페이지 인덱스
  final RxInt _currentPageIndex = 0.obs;

  // 로딩스크린
  // 현재 텍스트 상태
  final RxList<String> steps = [
    "제출하신 이력서를 검토하고 있습니다...",
    "지원자의 역량을 분석하고 있습니다...",
    "최종 회의를 통해 결정 중입니다..."
  ].obs;

  // 변환 텍스트
  final List<String> updatedSteps = [
    "이력서 검토가 끝났습니다!",
    "역량 분석이 끝났습니다!",
    "회의를 통해 최종 승인되었어요!"
  ];

  // /* ------------------------------------------------------ */
  // /* ----------------- Public Fields ---------------------- */
  // /* ------------------------------------------------------ */
  PageController get pageController => _pageController;
  FlipCardController get flipCardController => _flipCardController;

  String get name => _name.value;
  bool get isNameValid => _isNameValid.value;
  String get birth => _birth.value;
  bool get isBirthValid => _isBirthValid.value;
  String get motivate => _motivate.value;
  bool get isMotivateValid => _isMotivateValid.value;
  String? get selectedGender =>
      _selectedGender.value.isEmpty ? null : _selectedGender.value;
  int get currentPageIndex => _currentPageIndex.value;

  set currentPageIndex(int value) => _currentPageIndex.value = value; // Setter

  // 로딩스크린

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection

    // 페이지 컨트롤러 초기화
    _pageController = PageController(viewportFraction: 1);

    // flipcard 컨트롤러 초기화
    _flipCardController = FlipCardController();
  }

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }

  // 이름 업데이트 및 유효성 검사
  void updateName(String value) {
    _name.value = value;
    _isNameValid.value = value.trim().isNotEmpty; // 유효성 검사 (비어있는지 확인)
  }

  // 생년월일 업데이트 및 유효성 검사
  void updateBirth(String value) {
    _birth.value = value;
    _isBirthValid.value = value.trim().isNotEmpty; // 유효성 검사 (비어있는지 확인)
  }

  // 자기소개 업데이트 및 유효성 검사
  void updateMotivate(String value) {
    _motivate.value = value;
    _isMotivateValid.value = value.trim().isNotEmpty; // 유효성 검사 (비어있는지 확인)
  }

  void selectGender(String gender) {
    _selectedGender.value = gender;
  }

  // 로딩스크린
  void startAnimation() {
    for (int i = 0; i < steps.length; i++) {
      Future.delayed(Duration(seconds: 2 * (i + 1)), () {
        steps[i] = updatedSteps[i]; // i번째 텍스트를 업데이트

        if (i == steps.length - 1) {
          Future.delayed(const Duration(seconds: 2), () {
            Get.to(() => const OnboardingResultScreen());
          });
        }
      });
    }
  }

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
}
