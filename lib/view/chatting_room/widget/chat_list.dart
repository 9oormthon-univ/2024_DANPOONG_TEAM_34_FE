import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/view/base/base_widget.dart';
import 'package:rebootOffice/view/chatting_room/widget/ai_chat_bubble.dart';
import 'package:rebootOffice/view/chatting_room/widget/user_chat_bubble.dart';
import 'package:rebootOffice/view_model/chatting_room/chatting_room_view_model.dart';

class ChatListView extends BaseWidget<ChattingRoomViewModel> {
  const ChatListView({
    super.key,
  });

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: viewModel.chatList.length,
        itemBuilder: (context, index) {
          final message = viewModel.chatList[index];
          final isUser = message.speaker == "USER";
          final showProfile = index == 0 ||
              viewModel.chatList[index - 1].speaker != message.speaker;

          return isUser
              ? UserChatBubble(message: message)
              : AIChatBubble(
                  message: message,
                  showProfile: showProfile,
                  eChatType: viewModel.selectedChatType);
        },
      ),
    );
  }
}
