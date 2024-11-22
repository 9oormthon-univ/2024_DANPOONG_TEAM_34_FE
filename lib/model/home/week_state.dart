// "journalResponseDto": {
// "workStartTime": "2024-11-22",
// "workEndTime": "2024-11-22",
// "currentTime": "2024-11-22"
// },
//
class WeekState {
  final DateTime workStartTime;
  final DateTime workEndTime;
  final DateTime currentTime;

  WeekState({
    required this.workStartTime,
    required this.workEndTime,
    required this.currentTime,
  });

  WeekState.initial()
      : workStartTime = DateTime.now(),
        workEndTime = DateTime.now(),
        currentTime = DateTime.now();

  factory WeekState.fromJson(Map<String, dynamic> json) {
    return WeekState(
      workStartTime: json['workStartTime'],
      workEndTime: json['workEndTime'],
      currentTime: json['currentTime'],
    );
  }
}
