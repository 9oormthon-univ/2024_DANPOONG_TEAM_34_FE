import 'package:get/get.dart';
import 'package:rebootOffice/view_model/chatting_list/chatting_room_list_view_model.dart';
import 'package:rebootOffice/view_model/chatting_room/chatting_room_view_model.dart';
import 'package:rebootOffice/view_model/onboarding/onboarding_view_model.dart';
import 'package:rebootOffice/view_model/login/login_view_model.dart';
import 'package:rebootOffice/view_model/see_more/see_more_view_model.dart';
import 'package:rebootOffice/view_model/statistics/statistics_view_model.dart';

import '../view_model/home/home_view_model.dart';
import '../view_model/root/root_view_model.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootViewModel>(() => RootViewModel());

    HomeBinding().dependencies();
    ChattingListBinding().dependencies();
    StatisticsBinding().dependencies();
    ChattingRoomBinding().dependencies();
    SeeMoreBinding().dependencies();
    OnboardingBinding().dependencies();
    LoginBinding().dependencies();
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewModel>(() => HomeViewModel());
  }
}

class ChattingListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChattingRoomListViewModel>(() => ChattingRoomListViewModel());
  }
}

class StatisticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatisticsViewModel>(() => StatisticsViewModel());
  }
}

class ChattingRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChattingRoomViewModel>(
      () => ChattingRoomViewModel(),
      fenix: true, // 컨트롤러가 삭제된 후 다시 생성될 때 새로운 인스턴스 생성
    );
  }
}

class SeeMoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeeMoreViewModel>(
      () => SeeMoreViewModel(),
    );
  }
}

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingViewModel>(
      () => OnboardingViewModel(),
    );
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginViewModel>(() => LoginViewModel());
  }
}
