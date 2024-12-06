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
            itemCount: _calculateItemCount(),
            itemBuilder: (context, index) {
              if (index == viewModel.chatList.length && viewModel.isLoading) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      viewModel.selectedChatType != 'FREE'
                          ? "보고중 ..."
                          : "전송중 ...",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                      ),
                    ),
                  ),
                );
              }

              // 현재 메시지와 이전 메시지의 날짜를 비교
              final message = viewModel.chatList[index];
              final previousMessage =
                  index > 0 ? viewModel.chatList[index - 1] : null;

              // 날짜가 변경되었거나 첫 메시지인 경우 날짜 구분선 표시
              if (previousMessage == null ||
                  !_isSameDay(message.createAt, previousMessage.createAt)) {
                return Column(
                  children: [
                    _buildDateDivider(message.createAt),
                    _buildMessageBubble(message, index),
                  ],
                );
              }

              return _buildMessageBubble(message, index);
            },
          ),
        ),
        Obx(() => viewModel.showSuccessAnimation
            ? const SuccessAnimation()
            : const SizedBox.shrink()),
      ],
    );
  }

  Widget _buildDateDivider(DateTime date) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey[300])),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _formatDate(date),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey[300])),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(dynamic message, int index) {
    final isUser = message.speaker == "USER";
    final showProfile = index == 0 ||
        viewModel.chatList[index - 1].speaker != message.speaker ||
        !_isSameDay(message.createAt, viewModel.chatList[index - 1].createAt);

    return isUser
        ? UserChatBubble(message: message)
        : AIChatBubble(
            message: message,
            showProfile: showProfile,
            eChatType: viewModel.selectedChatType,
          );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final yesterday = DateTime.now().subtract(const Duration(days: 1));

    if (_isSameDay(date, now)) {
      return "오늘";
    } else if (_isSameDay(date, yesterday)) {
      return "어제";
    } else {
      return "${date.year}년 ${date.month}월 ${date.day}일";
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  int _calculateItemCount() {
    return viewModel.chatList.length + (viewModel.isLoading ? 1 : 0);
  }
}
