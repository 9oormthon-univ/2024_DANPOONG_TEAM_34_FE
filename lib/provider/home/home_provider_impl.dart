import 'dart:core';

import 'package:get/get.dart';
import 'package:rebootOffice/provider/base/base_connect.dart';
import 'package:rebootOffice/provider/home/home_provider.dart';

class HomeProviderImpl extends BaseConnect implements HomeProvider {
  //TODO-[규진] 가변값으로 연결 필요

  @override
  Future<Map<String, dynamic>> readWeek() async {
    Response response;

    try {
      response = await get(
        '/analysis/journal',
      );
    } catch (e) {
      rethrow;
    }

    return response.body['data'];
  }

  @override
  Future<List<dynamic>> readDailyWork() async {
    Response response;

    try {
      response = await get(
        '/analysis/list',
      );
    } catch (e) {
      rethrow;
    }

    return response.body['data'];
  }
}
