import "package:firebase_core/firebase_core.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:kakao_flutter_sdk/kakao_flutter_sdk.dart";
import "package:rebootOffice/app/firebase/local_fcm_service.dart";

import "app/factory/secure_storage_factory.dart";
import "app/main_app.dart";
import "firebase_options.dart";

void main() async {
  await onSystemInit();
  // Firebase 초기화

  runApp(const MainApp());
}

Future<void> onSystemInit() async {
  // WidgetsBinding
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Firebase 초기화 및 FCM 토큰 받기를 스플래시 스크린이 띄워졌을 떄 진행합니다.
  // Environment
  await dotenv.load(fileName: "assets/config/.env");
  KakaoSdk.init(nativeAppKey: "${dotenv.env['KAKAO_APP_KEY']}");

  final localNotificationService = LocalFcmNotificationService();
  await localNotificationService.initNotification();

  // 알림 스케줄 설정
  await localNotificationService.testNotifications();

  // 키 해시 출력
  print(await KakaoSdk.origin);

  await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  //
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  //
  // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //   print('사용자가 알림을 허용했습니다.');
  //
  //   // FCM 토큰 받기
  //   String? token = await messaging.getToken();
  //   print('FCM Token: $token');
  // }

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 스플래시 스크린 제거
  FlutterNativeSplash.remove();

  // Date Binding

  // await initializeDateFormatting();
  // tz.initializeTimeZones();

  // Environment

  // Factory
  await SecureStorageFactory().onInit();
}
