import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';
import 'package:rebootOffice/utility/static/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingMiddleware extends GetMiddleware {
  @override
  int? get priority => 2;

  @override
  RouteSettings? redirect(String? route) {
    // 현재 라우트가 이미 온보딩이면 리다이렉트하지 않음
    if (route == Routes.ON_BOARDING) {
      LogUtil.debug("라우팅이 이미 온보딩입니다.");
      return null;
    }

    final prefs = Get.find<SharedPreferences>();
    final hasCompletedOnboarding =
        prefs.getBool('hasCompletedOnboarding') ?? false;

    if (!hasCompletedOnboarding) {
      LogUtil.debug("라우팅을 온보딩으로 수정합니다.");
      return const RouteSettings(name: Routes.ON_BOARDING);
    }
    return null;
  }
}
