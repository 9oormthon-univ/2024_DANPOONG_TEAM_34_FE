import "package:shared_preferences/shared_preferences.dart"
    show SharedPreferences;

class OnboardingService {
  static const String _onboardingKey = 'has_completed_onboarding';

  static Future<bool> hasCompletedOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  static Future<void> setOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }
}
