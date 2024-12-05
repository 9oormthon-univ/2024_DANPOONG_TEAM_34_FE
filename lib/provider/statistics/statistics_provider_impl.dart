import 'package:get/get.dart';
import 'package:rebootOffice/provider/base/base_connect.dart';
import 'package:rebootOffice/provider/statistics/statistics_provider.dart';

class StatisticsProviderImpl extends BaseConnect implements StatisticsProvider {
  @override
  Future<Map<String, dynamic>> readUserStatus() async {
    Response response;

    try {
      response = await get(
        '/analysis/users',
      );
    } catch (e) {
      rethrow;
    }

    return response.body['data'];
  }

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
  Future<List<dynamic>> readUserTaskList(DateTime date) async {
    Response response;
    var year = date.year;
    var month = date.month;
    var day = date.day;

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

  @override
  Future<Map<String, dynamic>> readUserAttendanceList(int index) async {
    Response response;
    String numToString = index.toString();
    try {
      response = await get(
        '/analysis/calendar',
        query: {
          'groupType': numToString,
        },
      );
      // 응답 데이터를 AttendanceState로 변환
      return response.body['data'];
    } catch (e) {
      rethrow;
    }
  }
}
