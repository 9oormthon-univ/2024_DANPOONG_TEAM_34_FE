import 'package:rebootOffice/model/statistics/attendance_state.dart';
import 'package:rebootOffice/model/statistics/period_state.dart';
import 'package:rebootOffice/model/statistics/task_state.dart';
import 'package:rebootOffice/model/statistics/user_status_state.dart';

abstract class StatisticsRepository {
  Future<UserStatusState> readUserStatus();
  Future<PeriodState> readUserPeriod();
  Future<List<TaskState>> readUserTaskList();
  Future<AttendanceState> readUserAttendanceList(int index);
}
