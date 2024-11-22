import 'package:intl/intl.dart';

class ChatState {
  final String chatContent;
  final String? imageUrl; // nullable로 변경
  final DateTime createAt;
  final String speaker;

  ChatState({
    required this.chatContent,
    this.imageUrl, // required 제거
    required this.createAt,
    required this.speaker,
  });

  factory ChatState.fromJson(Map<String, dynamic> json) {
    DateTime parseDateTime(String dateStr) {
      try {
        return DateTime.parse(dateStr);
      } catch (e) {
        final DateFormat formatter = DateFormat('yyyy-MM-dd\'T\'HH:mm:ss');
        return formatter.parse(dateStr.replaceAll(RegExp(r'::\d+'), ':00'));
      }
    }

    return ChatState(
      chatContent: json['chatContent'],
      imageUrl: json['imageUrl'], // null이 허용됨
      createAt: parseDateTime(json['createAt']),
      speaker: json['speaker'],
    );
  }
}
