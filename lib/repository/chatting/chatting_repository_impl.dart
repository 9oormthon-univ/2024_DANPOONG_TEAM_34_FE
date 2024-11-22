import 'dart:io';

import 'package:get/get.dart';
import 'package:rebootOffice/model/chatting/chat_state.dart';
import 'package:rebootOffice/model/chatting/chatting_room_state.dart';
import 'package:rebootOffice/provider/chatting/chatting_provider.dart';
import 'package:rebootOffice/repository/chatting/chatting_repository.dart';

class ChattingRepositoryImpl extends GetxService implements ChattingRepository {
  late final ChattingProvider _chattingProvider;

  @override
  void onInit() {
    super.onInit();
    _chattingProvider = Get.find<ChattingProvider>();
  }

  @override
  Future<List<ChattingRoomState>> readChattingRoomList() async {
    List<dynamic> data = await _chattingProvider.readChattingRoomList();
    return List<ChattingRoomState>.from(
        data.map((chattingRoom) => ChattingRoomState.fromJson(chattingRoom)));
  }

  @override
  Future<List<ChatState>> readChatList(int chatId) async {
    List<dynamic> data = await _chattingProvider.readChatList(chatId);
    return List<ChatState>.from(data.map((chat) => ChatState.fromJson(chat)));
  }

  @override
  Future<Response<dynamic>> sendChatMessage(
      int chatId, String question, String eChatType, File? imageFile) async {
    return await _chattingProvider.sendChatMessage(
        chatId, question, eChatType, imageFile);
  }
}
