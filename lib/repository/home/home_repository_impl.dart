import 'dart:core';

import 'package:get/get.dart';
import 'package:rebootOffice/model/home/daily_work_state.dart';
import 'package:rebootOffice/model/home/user_state.dart';
import 'package:rebootOffice/model/home/week_state.dart';
import 'package:rebootOffice/provider/home/home_provider.dart';
import 'package:rebootOffice/repository/home/home_repository.dart';

class HomeRepositoryImpl extends GetxService implements HomeRepository {
  late final HomeProvider _homeProvider;

  @override
  void onInit() {
    super.onInit();
    _homeProvider = Get.find<HomeProvider>();
  }

  @override
  Future<WeekState> readUserWeek() async {
    Map<String, dynamic> data = await _homeProvider.readWeek();
    return WeekState.fromJson(data);
  }

  @override
  Future<List<DailyWorkState>> readUserDailyWork() async {
    List<dynamic> data = await _homeProvider.readDailyWork();
    return data.map<DailyWorkState>((e) => DailyWorkState.fromJson(e)).toList();
  }

  @override
  Future<UserState> readUserState() async {
    Map<String, dynamic> data = await _homeProvider.readUserState();
    return UserState.fromJson(data);
  }
}
