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

  // /* ------------------------------------------------------ */
  // /* ----------------- Public Fields ---------------------- */
  // /* ------------------------------------------------------ */
  PageController get pageController => _pageController;

  @override
  void onInit() {
    super.onInit();
    // 페이지 컨트롤러 초기화
    _pageController = PageController(viewportFraction: 1);
  }
}
