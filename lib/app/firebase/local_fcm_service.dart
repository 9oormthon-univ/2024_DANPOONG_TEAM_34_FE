import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalFcmNotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    tz.initializeTimeZones();

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotifications({
    required int partTime,
    required String attendanceTime,
    required String workStartTime,
    required List<Map<String, String>> mealTimeList,
    required bool isOutside,
  }) async {
    // 알림 권한 요청
    final bool? result = await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    if (result ?? false) {
      final startDate = DateTime.parse(workStartTime);
      final attendance = DateTime.parse('$workStartTime $attendanceTime');

      for (int i = 0; i < partTime; i++) {
        final currentDate = startDate.add(Duration(days: i));

        // 출근 알림
        await _scheduleNotification(
          id: i * 5,
          title: '출근 알림',
          body: '출근 시간입니다.',
          scheduledDate: currentDate.copyWith(
            hour: attendance.hour,
            minute: attendance.minute,
          ),
        );

        // 식사 알림
        for (var meal in mealTimeList) {
          int hour;
          String title;

          switch (meal['mealTime']) {
            case 'MORNING':
              hour = 9;
              title = '아침 식사';
              break;
            case 'LUNCH':
              hour = 11;
              title = '점심 식사';
              break;
            case 'DINNER':
              hour = 16;
              title = '저녁 식사';
              break;
            default:
              continue;
          }

          await _scheduleNotification(
            id: i * 5 + mealTimeList.indexOf(meal) + 1,
            title: title,
            body: '$title 시간입니다.',
            scheduledDate: currentDate.copyWith(hour: hour),
          );
        }

        // 외근자 오후 3시 알림
        if (isOutside) {
          await _scheduleNotification(
            id: i * 5 + 4,
            title: '외근 체크',
            body: '외근 상황을 체크해주세요.',
            scheduledDate: currentDate.copyWith(hour: 15),
          );
        }
      }
      LogUtil.info("로컬 FCM 설정 끝");
    }
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: 'default',
          badgeNumber: 1,
          threadIdentifier: 'work_schedule_$id',
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  Future<void> testNotifications() async {
    final DateTime now = DateTime.now();

    // 알림 권한 요청
    final bool? result = await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    if (result ?? false) {
      // 5분동안 매분 알림 스케줄링
      for (int i = 0; i < 5; i++) {
        final scheduledTime = now.add(Duration(minutes: i));

        await _scheduleNotification(
          id: i,
          title: '테스트 알림 ${i + 1}',
          body: '${scheduledTime.hour}시 ${scheduledTime.minute}분 테스트 알림입니다.',
          scheduledDate: scheduledTime,
        );
      }
    }
  }
}
