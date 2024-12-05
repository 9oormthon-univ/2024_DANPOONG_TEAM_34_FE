import 'dart:core';

import 'package:get/get.dart';
import 'package:rebootOffice/provider/base/base_connect.dart';
import 'package:rebootOffice/provider/home/home_provider.dart';

class HomeProviderImpl extends BaseConnect implements HomeProvider {
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

  @override
  Future<Map<String, dynamic>> readUserState() async {
    Response response;

    try {
      response = await get(
        '/users',
      );
    } catch (e) {
      rethrow;
    }

    return response.body['data'];
  }
}
