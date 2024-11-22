class UserStatusState {
  DateTime workStartTime;
  DateTime workEndTime;
  DateTime currentTime;

  UserStatusState({
    required this.workStartTime,
    required this.workEndTime,
    required this.currentTime,
  });

  UserStatusState copyWith({
    DateTime? workStartTime,
    DateTime? workEndTime,
    DateTime? currentTime,
  }) {
    return UserStatusState(
      workStartTime: workStartTime ?? this.workStartTime,
      workEndTime: workEndTime ?? this.workEndTime,
      currentTime: currentTime ?? this.currentTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workStartTime': this.workStartTime,
      'workEndTime': this.workEndTime,
      'currentTime': this.currentTime,
    };
  }

  factory UserStatusState.fromJson(Map<String, dynamic> json) {
    return UserStatusState(
      workStartTime: json['workStartTime'] as DateTime,
      workEndTime: json['workEndTime'] as DateTime,
      currentTime: json['currentTime'] as DateTime,
    );
  }
  UserStatusState.initial()
      : workStartTime = DateTime.now(),
        workEndTime = DateTime.now(),
        currentTime = DateTime.now();
}
