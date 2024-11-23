abstract class HomeProvider {
  Future<Map<String, dynamic>> readWeek();
  Future<List<dynamic>> readDailyWork();
  Future<Map<String, dynamic>> readUserState();
}
