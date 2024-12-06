import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/view_model/home/home_view_model.dart';

class EndingViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */
  late final homeViewModel;
  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final PageController _pageController;
  late final RxString _nickname;

  final RxInt _currentPage = 0.obs;

  // /* ------------------------------------------------------ */
  // /* ----------------- Public Fields ---------------------- */
  // /* ------------------------------------------------------ */
  PageController get pageController => _pageController;
  int get currentPage => _currentPage.value;
  String get nickname => _nickname.value;

  set currentPage(int value) => _currentPage.value = value;

  @override
  void onInit() {
    super.onInit();
    // 페이지 컨트롤러 초기화
    homeViewModel = Get.find<HomeViewModel>();
    _nickname = ''.obs;
    _pageController = PageController(viewportFraction: 0.93);
    _startPageTransition();
  }

  @override
  void onReady() {
    super.onReady();
    _nickname.value = homeViewModel.userState.name;
  }

  void _startPageTransition() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      Future.delayed(const Duration(milliseconds: 2000), () {
        _pageController.animateToPage(
          2,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    });
  }
}
