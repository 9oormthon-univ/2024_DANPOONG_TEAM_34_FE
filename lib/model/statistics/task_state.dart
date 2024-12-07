class TaskState {
  final String chatType;
  final String createdAt;
  final String? imageUrl; // null 허용
  final String content;

  TaskState({
    required this.chatType,
    required this.createdAt,
    this.imageUrl, // required 제거
    required this.content,
  });

  TaskState copyWith({
    String? chatType,
    String? createdAt,
    String? imageUrl,
    String? description,
  }) {
    return TaskState(
      chatType: chatType ?? this.chatType,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
      content: description ?? content,
    );
  }

  factory TaskState.fromJson(Map<String, dynamic> data) {
    return TaskState(
      chatType: data['chatType'] as String,
      createdAt: data['createdAt'] as String,
      imageUrl: data['imageUrl'] as String?, // null 허용으로 캐스팅
      content: data['content'] as String,
    );
  }

  static List<TaskState> initial() {
    return [];
  }
}
