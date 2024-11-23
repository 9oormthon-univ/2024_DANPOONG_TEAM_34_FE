class TaskState {
  final String chatType;
  final String createdAt;
  final String imageUrl;
  final String content;

  TaskState({
    required this.chatType,
    required this.createdAt,
    required this.imageUrl,
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
      content: description ?? this.content,
    );
  }

  // factory ChatState.fromJson(Map<String, dynamic> json) {
  //   DateTime parseDateTime(String dateStr) {
  //     try {
  //       return DateTime.parse(dateStr);
  //     } catch (e) {
  //       final DateFormat formatter = DateFormat('yyyy-MM-dd\'T\'HH:mm:ss');
  //       return formatter.parse(dateStr.replaceAll(RegExp(r'::\d+'), ':00'));
  //     }
  //   }
  //
  //   return ChatState(
  //     chatContent: json['chatContent'],
  //     imageUrl: json['imageUrl'], // null이 허용됨
  //     createAt: parseDateTime(json['createAt']),
  //     speaker: json['speaker'],
  //   );
  // }
  factory TaskState.fromJson(Map<String, dynamic> data) {
    return TaskState(
      chatType: data['chatType'] as String,
      createdAt: data['createdAt'] as String,
      imageUrl: data['imageUrl'] as String,
      content: data['content'] as String,
    );
  }

  static List<TaskState> initial() {
    return [];
  }
}
