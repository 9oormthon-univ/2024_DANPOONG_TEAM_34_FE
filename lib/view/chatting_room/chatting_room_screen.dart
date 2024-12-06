import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/functions/enumToKorean.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view/chatting_room/widget/chat_list.dart';
import 'package:rebootOffice/view_model/chatting_room/chatting_room_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_back_appbar.dart';
import 'package:rebootOffice/widget/bottom_sheet/custom_bottom_sheet.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';

class ChattingRoomScreen extends BaseScreen<ChattingRoomViewModel> {
  ChattingRoomScreen({super.key});
  final Map<String, dynamic> args = Get.arguments;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: DefaultBackAppBar(
        showBackButton: true,
        title: enumToKorean(args['eChatType']),
        onBackPress: () => {Get.back()},
        centerTitle: true,
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    viewModel.fetchChatList(args['chatRoomId']);
    viewModel.selectedChatType = args['eChatType'];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        viewModel.scrollToBottom();
      },
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                // 채팅 리스트가 업데이트될 때마다 즉시 스크롤
                if (viewModel.chatList.isNotEmpty) {
                  // 마이크로태스크 큐에 스크롤 작업 추가
                  Future.microtask(() => viewModel.scrollToBottom());
                }
                return const ChatListView();
              },
            ),
          ),
          viewModel.selectedChatType == 'FREE'
              ? _buildChatInputField(context)
              : _buildReportButton(context),
        ],
      ),
    );
  }

  Widget _buildChatInputField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Add image preview
          Obx(() => viewModel.hasImage && viewModel.imageFile != null
              ? Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  height: 100,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.file(
                        viewModel.imageFile!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          viewModel.setImageFile(null);
                          viewModel.setHasImageFile(false);
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox()),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: viewModel.contentController,
                  decoration: const InputDecoration(
                    hintText: '메시지를 입력해주세요',
                    border: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) {
                    viewModel.sendMessage(viewModel.chatRoomId);
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () => viewModel.checkAndRequestCameraPermission(),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  await viewModel.sendMessage(viewModel.chatRoomId);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportButton(BuildContext context) {
    return Container(
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
    );
  }
}
