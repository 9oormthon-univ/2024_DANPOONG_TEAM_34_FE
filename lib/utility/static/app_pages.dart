import 'package:get/get.dart';
import 'package:rebootOffice/binding/root_binding.dart';
import 'package:rebootOffice/middleware/login_middleware.dart';
import 'package:rebootOffice/middleware/on_boarding_middleware.dart';
import 'package:rebootOffice/view/chatting_room/chatting_room_screen.dart';
import 'package:rebootOffice/view/ending/ending_screen.dart';
import 'package:rebootOffice/view/login/login_screen.dart';
import 'package:rebootOffice/view/onboarding/onboarding_screen.dart';
import 'package:rebootOffice/view/register/register_screen.dart';
// import 'package:rebootOffice/middleware/login_middleware.dart';
import 'package:rebootOffice/view/root/root_screen.dart';
import 'package:rebootOffice/view/statistics_detail/statistics_detail_screen.dart';

import 'app_routes.dart';

List<GetPage> appPages = [
  GetPage(
    name: Routes.ROOT,
    page: () => const RootScreen(),
    binding: RootBinding(),
    middlewares: [
      LoginMiddleware(),
      OnboardingMiddleware(),
    ],
  ),
  GetPage(
    name: Routes.ON_BOARDING,
    page: () => const OnboardingScreen(),
    binding: OnboardingBinding(),
    middlewares: [
      LoginMiddleware(),
    ],
  ),
  GetPage(
    name: Routes.REGISTER,
    page: () => const RegisterScreen(),
    binding: RegisterBinding(),
    middlewares: [
      LoginMiddleware(),
    ],
  ),
  GetPage(
    name: Routes.CHATTING_ROOM,
    page: () => ChattingRoomScreen(),
    binding: ChattingRoomBinding(),
  ),
  GetPage(
    name: Routes.LOGIN,
    page: () => const LoginScreen(),
    binding: LoginBinding(),
    middlewares: [
      // LoginMiddleware(),
    ],
  ),
  GetPage(
    name: Routes.STATISTICS_DETAIL,
    page: () => const StatisticsDetailScreen(),
    binding: StatissticDetailBinding(),
    middlewares: [
      LoginMiddleware(),
    ],
  ),
  GetPage(
    name: Routes.ENDING,
    page: () => const EndingScreen(),
    binding: EndingBinding(),
    middlewares: [
      LoginMiddleware(),
    ],
  ),
];
