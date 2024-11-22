import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view/chatting_room/widget/chat_list.dart';
import 'package:rebootOffice/view_model/chatting_room/chatting_room_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_back_appbar.dart';
import 'package:rebootOffice/widget/bottom_sheet/custom_bottom_sheet.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';

class ChattingRoomScreen extends BaseScreen<ChattingRoomViewModel> {
  final int chattingRoomId;
  const ChattingRoomScreen(this.chattingRoomId, {super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: DefaultBackAppBar(
        showBackButton: true,
        title: '채팅방',
        onBackPress: () => {Get.back()},
        centerTitle: true,
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    viewModel.fetchChatList(chattingRoomId);
    return Column(
      children: [
        _buildDateHeader(),
        const Expanded(
          child: ChatListView(),
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
      ],
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
}
