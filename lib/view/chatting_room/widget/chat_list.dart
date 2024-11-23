import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/view/base/base_widget.dart';
import 'package:rebootOffice/view/chatting_room/widget/ai_chat_bubble.dart';
import 'package:rebootOffice/view/chatting_room/widget/user_chat_bubble.dart';
import 'package:rebootOffice/view_model/chatting_room/chatting_room_view_model.dart';
import 'package:rebootOffice/widget/animation/success_animation.dart';

class ChatListView extends BaseWidget<ChattingRoomViewModel> {
  const ChatListView({
    super.key,
  });

  @override
  Widget buildView(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => ListView.builder(
            controller: viewModel.scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount:
                viewModel.chatList.length + (viewModel.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == viewModel.chatList.length && viewModel.isLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      "보고중 ...",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                      ),
                    ),
                  ),
                );
              }

              final message = viewModel.chatList[index];
              final isUser = message.speaker == "USER";
              final showProfile = index == 0 ||
                  viewModel.chatList[index - 1].speaker != message.speaker;

              return isUser
                  ? UserChatBubble(message: message)
                  : AIChatBubble(
                      message: message,
                      showProfile: showProfile,
                      eChatType: viewModel.selectedChatType,
                    );
            },
          ),
        ),
        Obx(() => viewModel.showSuccessAnimation
            ? const SuccessAnimation()
            : const SizedBox.shrink()),
      ],
    );
  }
}
