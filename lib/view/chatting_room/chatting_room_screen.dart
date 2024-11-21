import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/model/chatting/chat_state.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view_model/chatting_room/chatting_room_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_back_appbar.dart';
import 'package:rebootOffice/widget/bottom_sheet/custom_bottom_sheet.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';

class ChattingRoomScreen extends BaseScreen<ChattingRoomViewModel> {
  const ChattingRoomScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: DefaultBackAppBar(
          showBackButton: true,
          title: '채팅방',
          onBackPress: () => {Get.back()},
          centerTitle: true,
        ));
  }

  @override
  Widget buildBody(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          _buildDateHeader(),
          Expanded(
            child: _buildChatList(),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: RoundedRectangleTextButton(
              text: "보고서 작성하기",
              width: Get.width * 0.9,
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: ColorSystem.blue.shade500,
              textStyle: FontSystem.KR16EB.copyWith(color: Colors.white),
              onPressed: () {
                showReportBottomSheet(context);
              },
            ),
          ),

          // _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildDateHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: ColorSystem.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '2024년 11월 6일 수요일',
          style: FontSystem.KR14R.copyWith(color: ColorSystem.grey.shade600),
        ),
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        return _buildChatBubble(controller.messages[index]);
      },
    );
  }

  Widget _buildChatBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: ColorSystem.grey.shade300,
            child: Image.asset('assets/images/default_npc.png'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.sender,
                  style: FontSystem.KR14B,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: ColorSystem.blue.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message.content,
                        style: FontSystem.KR14R,
                      ),
                    ),
                    Text(
                      message.time,
                      style: FontSystem.KR12R
                          .copyWith(color: ColorSystem.grey.shade600),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageController,
              decoration: InputDecoration(
                hintText: '메시지를 입력하세요',
                hintStyle:
                    FontSystem.KR14R.copyWith(color: Colors.grey.shade400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: controller.sendMessage,
            icon: const Icon(Icons.send),
            color: ColorSystem.blue.shade500,
          ),
        ],
      ),
    );
  }
}
