import 'package:get/get.dart';
import 'package:rebootOffice/utility/static/app_routes.dart';
import 'package:rebootOffice/view_model/root/root_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> completeOnboarding() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('hasCompletedOnboarding', true);
  Get.put(RootViewModel); // 강제로 초기화
  // 또는
  Get.offAllNamed(Routes.ROOT);

  // Get.offAllNamed(Routes.ROOT);
}
