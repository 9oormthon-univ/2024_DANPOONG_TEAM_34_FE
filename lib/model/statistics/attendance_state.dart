class AttendanceState {
  final int success;
  final int unclear;
  final int fail;
  final DateTime workStartTime;
  final DateTime workEndTime;
  final DateTime currentTime;
  final List<CalendarItem> calendarItems;

  AttendanceState({
    required this.success,
    required this.unclear,
    required this.fail,
    required this.workStartTime,
    required this.workEndTime,
    required this.currentTime,
    required this.calendarItems,
  });

  factory AttendanceState.fromJson(Map<String, dynamic> json) {
    return AttendanceState(
      success: json['success'] ?? 0,
      unclear: json['unclear'] ?? 0,
      fail: json['fail'] ?? 0,
      workStartTime: DateTime.parse(json['workStartTime']),
      workEndTime: DateTime.parse(json['workEndTime']),
      currentTime: DateTime.parse(json['currentTime']),
      calendarItems: (json['calendarItemResponseDto'] as List)
          .map((item) => CalendarItem.fromJson(item))
          .toList(),
    );
  }

  factory AttendanceState.empty() {
    return AttendanceState(
      success: 0,
      unclear: 0,
      fail: 0,
      workStartTime: DateTime.now(),
      workEndTime: DateTime.now(),
      currentTime: DateTime.now(),
      calendarItems: [],
    );
  }

  static Future<AttendanceState> initial() {
    return Future.value(AttendanceState.empty());
  }
}

class CalendarItem {
  final DateTime itemTime;
  final String status;

  CalendarItem({
    required this.itemTime,
    required this.status,
  });

  factory CalendarItem.fromJson(Map<String, dynamic> json) {
    return CalendarItem(
      itemTime: DateTime.parse(json['itemTime']),
      status: json['status'],
    );
  }
}
