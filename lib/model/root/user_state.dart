class UserState {
  final String encryptedId;
  final String nickname;
  final String environmentalTemperature;
  final bool isActiveNotification;
  final int notificationHour;
  final int notificationMinute;

  UserState({
    required this.encryptedId,
    required this.nickname,
    required this.environmentalTemperature,
    required this.isActiveNotification,
    required this.notificationHour,
    required this.notificationMinute,
  });

  UserState.initial()
      : encryptedId = '',
        nickname = '사용자',
        environmentalTemperature = '0.0',
        isActiveNotification = true,
        notificationHour = 0,
        notificationMinute = 0;

  UserState copyWith({
    String? encryptedId,
    String? nickname,
    String? environmentalTemperature,
    bool? isActiveNotification,
    int? notificationHour,
    int? notificationMinute,
  }) {
    return UserState(
      encryptedId: encryptedId ?? this.encryptedId,
      nickname: nickname ?? this.nickname,
      environmentalTemperature:
          environmentalTemperature ?? this.environmentalTemperature,
      isActiveNotification: isActiveNotification ?? this.isActiveNotification,
      notificationHour: notificationHour ?? this.notificationHour,
      notificationMinute: notificationMinute ?? this.notificationMinute,
    );
  }

  factory UserState.fromJson(Map<String, dynamic> data) {
    return UserState(
      encryptedId: data['encryptedId'],
      nickname: data['nickname'],
      environmentalTemperature: data['environmentalTemperature'],
      isActiveNotification: data['isActiveNotification'],
      notificationHour: data['notificationHour'],
      notificationMinute: data['notificationMinute'],
    );
  }

  @override
  String toString() {
    return 'UserState(encryptedId: $encryptedId, nickname: $nickname, environmentalTemperature: $environmentalTemperature, isActiveNotification: $isActiveNotification, notificationHour: $notificationHour, notificationMinute: $notificationMinute)';
  }
}
