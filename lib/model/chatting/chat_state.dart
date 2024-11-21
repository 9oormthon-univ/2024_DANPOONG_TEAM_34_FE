// 메시지 관련 클래스와 컨트롤러

class ChatMessage {
  final String sender;
  final String content;
  final String time;

  ChatMessage({
    required this.sender,
    required this.content,
    required this.time,
  });
}
