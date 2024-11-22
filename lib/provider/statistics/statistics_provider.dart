abstract class StatisticsProvider {
  Future<Map<String, dynamic>> readUserStatus();
  Future<Map<String, dynamic>> readUserPeriod();
}
