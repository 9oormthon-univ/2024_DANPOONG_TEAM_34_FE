import 'package:flutter/material.dart';
import 'package:get/get.dart';

@immutable
abstract class BaseWidget<T extends GetxController> extends GetView<T> {
  const BaseWidget({super.key});

  /// 뷰 모델을 가져오는 메서드
  T get viewModel => controller;

  @override
  Widget build(BuildContext context) {
    return buildView(context);
  }

  /// 하위 클래스에서 반드시 구현되어야 하는 메서드, 해당 메서드에서는 화면을 실제로 구성하는 위젯을 반환해야 함
  Widget buildView(BuildContext context);
}
