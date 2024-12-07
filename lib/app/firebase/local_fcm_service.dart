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
          final mealIndex = mealTimeList.indexOf(meal);
          final uniqueId = (i * 100) + (mealIndex + 1) * 10;

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
              hour = 20;
              title = '저녁 식사';
              break;
            default:
              continue;
          }

          final now = DateTime.now();
          DateTime scheduledDateTime;

          // i가 0일 때(첫째 날)는 현재 날짜 기준으로 처리
          if (i == 0) {
            scheduledDateTime = DateTime(
              now.year,
              now.month,
              now.day,
              hour,
            );

            // 현재 시간이 예약하려는 시간보다 이후라면 다음 날로 설정
            if (now.hour > hour) {
              scheduledDateTime =
                  scheduledDateTime.add(const Duration(days: 1));
            }
          } else {
            // 둘째 날부터는 startDate 기준으로 처리
            scheduledDateTime =
                startDate.add(Duration(days: i)).copyWith(hour: hour);
          }

          LogUtil.info("알림 예약 시도: $title, 시간: $scheduledDateTime"); // 디버깅용 로그

          await _scheduleNotification(
            id: uniqueId,
            title: title,
            body: '$title 시간입니다.',
            scheduledDate: scheduledDateTime,
          );

          LogUtil.info("알림 예약 완료: $title, 시간: $scheduledDateTime");
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
    final scheduledTZ = tz.TZDateTime.from(
        scheduledDate, tz.getLocation('Asia/Seoul')); // 한국 시간대로 명시

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTZ,
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
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  Future<void> testNotifications() async {
    final DateTime now = DateTime.now();
    final DateTime scheduledTime = now.add(const Duration(minutes: 1)); // 1분 후

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
      await _scheduleNotification(
        id: 1,
        title: '출근 시간입니다.',
        body: '${scheduledTime.hour}시 ${scheduledTime.minute}분 출근 알림입니다.',
        scheduledDate: scheduledTime,
      );
    }
  }
}
