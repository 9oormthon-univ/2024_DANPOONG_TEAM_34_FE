// 출석 상태를 enum으로 정의
enum AttendanceStatus {
  complete, // 완료 (초록색 체크)
  warning, // 노력필요 (노란색 경고)
  absent, // 업무불참 (빨간색 X)
  upcoming // 예정된 날짜
}

// 출석 데이터 모델
class AttendanceState {
  final DateTime date;
  final AttendanceStatus status;

  AttendanceState({
    required this.date,
    required this.status,
  });

  AttendanceState copyWith({
    DateTime? date,
    AttendanceStatus? status,
  }) {
    return AttendanceState(
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}
