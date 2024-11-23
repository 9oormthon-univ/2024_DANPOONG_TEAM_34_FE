import 'package:get/get.dart';
import 'package:rebootOffice/utility/static/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> completeOnboarding() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('hasCompletedOnboarding', true);
  Get.offAllNamed(Routes.ROOT);
}
