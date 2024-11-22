import 'dart:io';

abstract class ChattingProvider {
  Future<List<dynamic>> readChattingRoomList();
  Future<List<dynamic>> readChatList(int chatId);
  Future<dynamic> sendChatMessage(
      int chatId, String question, String eChatType, File? imageFile);
}
