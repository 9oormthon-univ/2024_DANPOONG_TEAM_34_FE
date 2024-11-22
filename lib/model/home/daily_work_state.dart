class DailyWorkState {
  final String mission;
  final String startTime;
  final String endTime;
  final String status;

  DailyWorkState({
    required this.mission,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  DailyWorkState.initial()
      : mission = '',
        startTime = '',
        endTime = '',
        status = '';

  factory DailyWorkState.fromJson(Map<String, dynamic> json) {
    // 시간 문자열을 DateTime으로 변환
    return DailyWorkState(
      mission: json['mission'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      status: json['status'] as String,
    );
  }
}
