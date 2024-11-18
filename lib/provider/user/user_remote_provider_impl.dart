import 'package:get/get.dart';
import 'package:rebootOffice/provider/base/base_connect.dart';
import 'package:rebootOffice/provider/user/user_remote_provider.dart';

class UserRemoteProviderImpl extends BaseConnect implements UserRemoteProvider {
  @override
  Future<Map<String, dynamic>> getUserInformation() async {
    final Response response;

    try {
      response = await get(
        '/api/v1/users',
      );
    } catch (e) {
      rethrow;
    }

    return response.body['data'];
  }

  @override
  Future<void> updateUserNotificationActive(bool isActive) async {
    try {
      await patch(
        '/api/v1/users/notification',
        {
          'isActiveNotification': isActive,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUserNotificationTime(int hour, int minute) async {
    try {
      await patch(
        '/api/v1/users/notification-time',
        {
          'notificationHour': hour,
          'notificationMinute': minute,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
