abstract class StatisticsProvider {
  Future<Map<String, dynamic>> readUserStatus();
  Future<Map<String, dynamic>> readUserPeriod();
  Future<List<dynamic>> readUserTaskList();
  Future<Map<String, dynamic>> readUserAttendanceList(int index);
}
