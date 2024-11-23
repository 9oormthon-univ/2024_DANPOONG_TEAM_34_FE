import 'package:get/get.dart';
import 'package:rebootOffice/provider/base/base_connect.dart';
import 'package:rebootOffice/provider/statistics/statistics_provider.dart';

class StatisticsProviderImpl extends BaseConnect implements StatisticsProvider {
  //TODO-[규진] 가변값으로 연결 필요

  @override
  Future<Map<String, dynamic>> readUserStatus() async {
    Response response;

    try {
      response = await get(
        '/analysis/r',
      );
    } catch (e) {
      rethrow;
    }

    return response.body['data'];
  }

  //TODO-[규진] 가변값으로 연결 필요
  @override
  Future<Map<String, dynamic>> readUserPeriod() async {
    Response response;

    try {
      response = await get(
        '/analysis/remain-period',
      );
    } catch (e) {
      rethrow;
    }

    return response.body['data'];
  }

  @override
  Future<List<dynamic>> readUserTaskList() async {
    Response response;
    var year = DateTime.now().year;
    var month = DateTime.now().month;
    var day = DateTime.now().day;

    try {
      response = await get(
        '/analysis/calendar-detail',
        query: {
          'date': '$year-$month-$day',
        },
      );
    } catch (e) {
      rethrow;
    }

    return response.body['data'];
  }
}
