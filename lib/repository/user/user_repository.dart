import 'package:rebootOffice/model/root/user_state.dart';

abstract class UserRepository {
  Future<UserState> readUserState();

  Future<void> updateUserNotificationActive(bool isActive);

  Future<void> updateUserNotificationTime(int hour, int minute);
}
