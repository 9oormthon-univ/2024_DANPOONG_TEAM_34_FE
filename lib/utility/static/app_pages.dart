import 'package:get/get.dart';
import 'package:rebootOffice/binding/root_binding.dart';
import 'package:rebootOffice/middleware/login_middleware.dart';
import 'package:rebootOffice/view/chatting_room/chatting_room_screen.dart';
import 'package:rebootOffice/view/login/login_screen.dart';
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
    ],
  ),
  // GetPage(
  //   name: Routes.ON_BOARDING,
  //   page: () => const On(),
  //   binding: RootBinding(),
  //   middlewares: [
  //     // LoginMiddleware(),
  //   ],
  // ),
  GetPage(
    name: Routes.CHATTING_ROOM,
    page: () {
      return ChattingRoomScreen();
    },
    binding: ChattingRoomBinding(),
  ),

  GetPage(
    name: Routes.LOGIN,
    page: () => const LoginScreen(),
    binding: LoginBinding(),
    middlewares: const [
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
];
