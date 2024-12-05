abstract class StatisticsProvider {
  Future<Map<String, dynamic>> readUserStatus();
  Future<Map<String, dynamic>> readUserPeriod();
  Future<List<dynamic>> readUserTaskList(DateTime date);
  Future<Map<String, dynamic>> readUserAttendanceList(int index);
}
