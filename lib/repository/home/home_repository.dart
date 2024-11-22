import 'package:rebootOffice/model/home/daily_work_state.dart';
import 'package:rebootOffice/model/home/week_state.dart';

abstract class HomeRepository {
  Future<WeekState> readUserWeek();
  Future<List<DailyWorkState>> readUserDailyWork();
}
