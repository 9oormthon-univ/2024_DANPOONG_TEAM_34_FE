// shared_prefs_util.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtil {
  static const String keyHasUnreadMessage = 'hasUnreadMessage';

  static Future<void> setHasUnreadMessage(bool hasUnread) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyHasUnreadMessage, hasUnread);
  }

  static Future<bool> getHasUnreadMessage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyHasUnreadMessage) ?? false;
  }
}
