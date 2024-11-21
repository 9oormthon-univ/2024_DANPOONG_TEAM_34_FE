import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChattingListViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* -------------------- DI Fields ----------------------- */
  /* ------------------------------------------------------ */

  /* ------------------------------------------------------ */
  /* ----------------- Private Fields --------------------- */
  /* ------------------------------------------------------ */
  late final PageController _pageController;

  late final RxBool _isLoadingWhenOpenDialog;

  /* ------------------------------------------------------ */
  /* ----------------- Public Fields ---------------------- */
  /* ------------------------------------------------------ */
  PageController get pageController => _pageController;

  bool get isLoadingWhenOpenDialog => _isLoadingWhenOpenDialog.value;

  @override
  void onInit() {
    super.onInit();
    // Dependency Injection

    // Initialize private fields
    _pageController = PageController(viewportFraction: 0.83);

    _isLoadingWhenOpenDialog = false.obs;
  }

  @override
  void onReady() async {
    super.onReady();
  }

  void fetchQuizDetail(int index) async {
    _isLoadingWhenOpenDialog.value = true;

    _isLoadingWhenOpenDialog.value = false;
  }
}
