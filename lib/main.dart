import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/cupertino.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:rebootOffice/firebase_options.dart";

import "app/factory/secure_storage_factory.dart";
import "app/main_app.dart";

void main() async {
  await onSystemInit();
  // Firebase 초기화

  runApp(const MainApp());
}

Future<void> onSystemInit() async {
  // WidgetsBinding
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 1));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Firebase 초기화 성공');
  try {
    // APNS 토큰 먼저 확인

    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print('FCM Token: $fcmToken');
  } catch (e) {
    print('토큰 발급 실패: $e');
  }

  // 스플래시 스크린 제거
  FlutterNativeSplash.remove();

  // Date Binding

  // await initializeDateFormatting();
  // tz.initializeTimeZones();

  // Environment

  // await dotenv.load(fileName: "assets/config/.env");
  // KakaoSdk.init(nativeAppKey: "${dotenv.env['KAKAO_APP_KEY']}");

  // Factory
  await SecureStorageFactory().onInit();
}
