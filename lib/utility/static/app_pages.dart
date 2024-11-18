import 'package:get/get.dart';
import 'package:rebootOffice/binding/root_binding.dart';
// import 'package:rebootOffice/middleware/login_middleware.dart';
import 'package:rebootOffice/view/root/root_screen.dart';

import 'app_routes.dart';

List<GetPage> appPages = [
  GetPage(
    name: Routes.ROOT,
    page: () => const RootScreen(),
    binding: RootBinding(),
    middlewares: [
      // LoginMiddleware(),
    ],
  ),
];
