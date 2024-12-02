import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EndingViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */
  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final PageController _pageController;
  final RxInt _currentPage = 0.obs;

  // /* ------------------------------------------------------ */
  // /* ----------------- Public Fields ---------------------- */
  // /* ------------------------------------------------------ */
  PageController get pageController => _pageController;
  int get currentPage => _currentPage.value;

  set currentPage(int value) => _currentPage.value = value;

  @override
  void onInit() {
    super.onInit();
    // 페이지 컨트롤러 초기화
    _pageController = PageController(viewportFraction: 0.93);
    _startPageTransition();
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
