class UserState {
  final String name;
  final String nameEn;
  final String email;

  UserState({
    required this.name,
    required this.nameEn,
    required this.email,
  });

  factory UserState.fromJson(Map<String, dynamic> data) {
    return UserState(
      name: data['name'] as String,
      nameEn: data['nameEn'] as String,
      email: data['email'] as String,
    );
  }

  UserState copyWith({
    String? name,
    String? nameEn,
    String? email,
  }) {
    return UserState(
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      email: email ?? this.email,
    );
  }

  UserState.initial()
      : name = '',
        nameEn = '',
        email = '';
}
