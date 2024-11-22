import 'dart:io';

import 'package:get/get.dart';
import 'package:rebootOffice/model/chatting/chat_state.dart';
import 'package:rebootOffice/model/chatting/chatting_room_state.dart';

abstract class ChattingRepository {
  Future<List<ChattingRoomState>> readChattingRoomList();
  Future<List<ChatState>> readChatList(int chatId);

  Future<Response<dynamic>> sendChatMessage(
      int chatId, String question, String eChatType, File? imageFile);
}
