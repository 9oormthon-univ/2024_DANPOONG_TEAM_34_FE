import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/repository/on_boarding/on_boarding_repository.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';

import '../../view/onboarding/onboarding_result_screen.dart';

class OnboardingViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */
  late final OnBoardingRepository _onBoardingRepository;
  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final PageController _pageController;

  late final FlipCardController _flipCardController;

  late final TextEditingController _textController;
  late final TextEditingController _textEnController;
  late final RxBool _isNameButtonEnabled = false.obs;

  late final TextEditingController _textBirthController;
  late final RxBool _isBirthButtonEnabled = false.obs;

  late final TextEditingController _textMotivateController;
  late final RxBool _isMotivateButtonEnabled = false.obs;

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

  TextEditingController get textController => _textController;
  TextEditingController get textEnController => _textEnController;
  bool get isNameButtonEnabled => _isNameButtonEnabled.value;

  TextEditingController get textBirthController => _textBirthController;
  bool get isBirthButtonEnabled => _isBirthButtonEnabled.value;

  TextEditingController get textMotivateController => _textMotivateController;
  bool get isMotivateButtonEnabled => _isMotivateButtonEnabled.value;

  String? get selectedGender =>
      _selectedGender.value.isEmpty ? '남성' : _selectedGender.value;
  int get currentPageIndex => _currentPageIndex.value;
  // 이름 getter 추가
  String get userName => textController.text;
  String get userNameEn => textEnController.text;

  set currentPageIndex(int value) => _currentPageIndex.value = value; // Setter

  // 로딩스크린

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection
    _onBoardingRepository = Get.find<OnBoardingRepository>();
    // 페이지 컨트롤러 초기화
    _pageController = PageController(viewportFraction: 1);

    // TextEditingController 초기화
    _textController = TextEditingController();
    _textEnController = TextEditingController();
    _textBirthController = TextEditingController();
    _textMotivateController = TextEditingController();

    textController.addListener(() {
      // 이름 필드가 비어있지 않으면 버튼 활성화
      _isNameButtonEnabled.value =
          textController.text.isNotEmpty || textEnController.text.isNotEmpty;
    });

    textEnController.addListener(() {
      // 영문 이름 필드가 비어있지 않으면 버튼 활성화
      _isNameButtonEnabled.value =
          textController.text.isNotEmpty || textEnController.text.isNotEmpty;
    });
    textBirthController.addListener(() {
      _isBirthButtonEnabled.value = textBirthController.text.isNotEmpty;
    });
    textMotivateController.addListener(() {
      _isMotivateButtonEnabled.value = textMotivateController.text.isNotEmpty;
    });

    // flipcard 컨트롤러 초기화
    _flipCardController = FlipCardController();
  }

  @override
  void onClose() {
    _pageController.dispose();
    _textController.dispose();
    _textBirthController.dispose();
    _textMotivateController.dispose();
    super.onClose();
  }

  void onTextChanged(String text) {
    _isNameButtonEnabled.value = text.isNotEmpty;
  }

  void selectGender(String gender) {
    _selectedGender.value = gender;
  }

  // 로딩스크린
  void startAnimation() {
    for (int i = 0; i < steps.length; i++) {
      Future.delayed(Duration(seconds: 1 * (i + 1)), () {
        steps[i] = updatedSteps[i]; // i번째 텍스트를 업데이트

        if (i == steps.length - 1) {
          Future.delayed(const Duration(seconds: 1), () {
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

  // String formatBirthday(String birthday) {
  //   if (birthday.length == 8) {
  //     return '${birthday.substring(0, 4)}-${birthday.substring(4, 6)}-${birthday.substring(6, 8)}';
  //   }
  //   return birthday;
  // }

  Future<void> submitUserData() async {
    try {
      // 입력값 검증
      if (textBirthController.text.isEmpty ||
          textMotivateController.text.isEmpty) {
        LogUtil.debug('생일 또는 지원동기가 비어있습니다.');
        return;
      }

      // API 호출 await 처리
      final response = await _onBoardingRepository.sendOnBoardingData(
        textController.text,
        textEnController.text,
        selectedGender!,
        textBirthController.text,
        textMotivateController.text,
      );

      final Map<String, dynamic> userData = {
        "name": textController.text,
        "nameEn": textEnController.text,
        "gender": selectedGender,
        "birthday": textBirthController.text,
        "motivation": textMotivateController.text
      };

      LogUtil.debug('전송할 데이터: ${userData.toString()}');
      LogUtil.debug('API 응답: ${response.body}');

      if (response.isOk) {
        // 성공 처리
        Get.offAndToNamed('/register');
      } else {
        // 실패 처리
        LogUtil.debug('데이터 전송 실패: ${response.statusText}');
      }
    } catch (e) {
      LogUtil.error('데이터 전송 중 오류 발생: $e');
    }
  }
}
