abstract class UserRemoteProvider {
  Future<Map<String, dynamic>> getUserInformation();

  Future<void> updateUserNotificationActive(bool isActive);

  Future<void> updateUserNotificationTime(int hour, int minute);
}
