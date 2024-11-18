import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/color_system.dart';

@immutable
abstract class BaseScreen<T extends GetxController> extends GetView<T> {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// 만약 뷰 모델이 초기화되지 않았다면 초기화 메서드를 호출
    if (!viewModel.initialized) {
      initViewModel();
    }

    /// SafeArea로 감싸거나 감싸지 않는 옵션에 따라 화면을 구성
    return Container(
      // decoration: BoxDecoration(
      //   color: unSafeAreaColor,
      // ),
      decoration: BoxDecoration(
        /// 조건에 따라 그라데이션 설정
        color: useGradientBackground ? null : unSafeAreaColor,

        /// 그라데이션 사용 여부
        gradient: useGradientBackground
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [ColorSystem.blue[300]!, Colors.white],
              )
            : null,
      ),
      child: wrapWithOuterSafeArea
          ? SafeArea(
              top: setTopOuterSafeArea,
              bottom: setBottomOuterSafeArea,
              child: _buildScaffold(context),
            )
          : _buildScaffold(context),
    );
  }

  /// Scaffold를 구성하는 메서드
  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      extendBody: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: screenBackgroundColor,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: buildFloatingActionButton,
      appBar: buildAppBar(context),
      body: wrapWithInnerSafeArea
          ? SafeArea(
              top: setTopInnerSafeArea,
              bottom: setBottomInnerSafeArea,
              child: buildBody(context),
            )
          : buildBody(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  /// 뷰 모델을 초기화하는 메서드
  @protected
  void initViewModel() {
    viewModel.initialized;
  }

  /// 뷰 모델을 가져오는 메서드
  @protected
  T get viewModel => controller;

  /// SafeArea의 색상을 정의하는 메서드
  @protected
  Color? get unSafeAreaColor => Colors.white;

  /// 키보드가 나타날 때 화면을 조절할지 여부를 정의하는 메서드
  @protected
  bool get resizeToAvoidBottomInset => true;

  /// Floating Action Button을 구성하는 메서드
  @protected
  Widget? get buildFloatingActionButton => null;

  /// Floating Action Button의 위치를 정의하는 메서드
  @protected
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  /// AppBar를 구성하는 메서드
  @protected
  bool get extendBodyBehindAppBar => false;

  /// 화면의 배경 색상을 정의하는 메서드
  @protected
  Color? get screenBackgroundColor => Colors.transparent;

  /// Scaffold 외부를 SafeArea로 감싸는지 여부를 정의하는 메서드
  @protected
  bool get wrapWithOuterSafeArea => false;

  /// 외부 SafeArea의 위쪽 부분을 설정할지 여부를 정의하는 메서드
  @protected
  bool get setTopOuterSafeArea => false;

  /// 외부 SafeArea의 아래쪽 부분을 설정할지 여부를 정의하는 메서드
  @protected
  bool get setBottomOuterSafeArea => false;

  /// Scaffold Body를 SafeArea로 감싸는지 여부를 정의하는 메서드
  @protected
  bool get wrapWithInnerSafeArea => false;

  /// 내부 SafeArea의 위쪽 부분을 설정할지 여부를 정의하는 메서드
  @protected
  bool get setTopInnerSafeArea => false;

  /// 내부 SafeArea의 아래쪽 부분을 설정할지 여부를 정의하는 메서드
  @protected
  bool get setBottomInnerSafeArea => false;

  /// AppBar를 구성하는 메서드
  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  /// 화면의 본문을 구성하는 메서드로 하위 클래스에서 반드시 구현되어야 함
  @protected
  Widget buildBody(BuildContext context);

  /// 화면 배경 색깔 그라데이션 적용 여부 정의하는 메서드
  bool get useGradientBackground => false;

  /// BottomNavigationBar를 구성하는 메서드
  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;
}
