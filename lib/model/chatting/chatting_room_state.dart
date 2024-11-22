class ChattingRoomState {
  late final int chatRoomId;
  late final String eChatType;
  late final String title;
  late final String messagePreview;
  late final int nonReadCount;
  late final String? createdAt; // null 가능하도록 변경

  ChattingRoomState({
    required this.chatRoomId,
    required this.eChatType,
    required this.title,
    required this.messagePreview,
    required this.nonReadCount,
    this.createdAt, // required 제거
  });

  ChattingRoomState copyWith({
    int? chatRoomId,
    String? eChatType,
    String? title,
    String? messagePreview,
    int? nonReadCount,
    String? createdAt,
  }) {
    return ChattingRoomState(
      chatRoomId: chatRoomId ?? this.chatRoomId,
      eChatType: eChatType ?? this.eChatType,
      title: title ?? this.title,
      messagePreview: messagePreview ?? this.messagePreview,
      nonReadCount: nonReadCount ?? this.nonReadCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory ChattingRoomState.initial() {
    return ChattingRoomState(
      chatRoomId: 0,
      eChatType: '',
      title: '',
      messagePreview: '',
      nonReadCount: 0,
      createdAt: null, // null로 초기화
    );
  }

  factory ChattingRoomState.fromJson(Map<String, dynamic> data) {
    return ChattingRoomState(
      chatRoomId: data['chatRoomId'] as int,
      eChatType: data['eChatType'] as String,
      title: data['title'] as String,
      messagePreview: data['messagePreview'] as String,
      nonReadCount: data['nonReadCount'] as int,
      createdAt: data['createdAt'] as String?, // null 가능하도록 변경
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomId': chatRoomId,
      'eChatType': eChatType,
      'title': title,
      'messagePreview': messagePreview,
      'nonReadCount': nonReadCount,
      'createdAt': createdAt,
    };
  }
}
