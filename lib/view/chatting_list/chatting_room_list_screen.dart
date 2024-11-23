import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/model/chatting/chatting_room_state.dart';
import 'package:rebootOffice/utility/static/app_routes.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view_model/chatting_list/chatting_room_list_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';

class ChattingRoomListScreen extends BaseScreen<ChattingRoomListViewModel> {
  const ChattingRoomListScreen({super.key});

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  bool get setBottomInnerSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: DefaultSvgAppBar(
        svgPath: 'assets/icons/appbar/header-logo.svg',
        height: 15,
        showBackButton: false,
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Obx(
      () => RefreshIndicator(
        onRefresh: () async {
          await viewModel.fetchChattingRoomList();
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          itemCount: viewModel.chattingRoomList.length,
          itemBuilder: (context, index) {
            return _chatListItem(viewModel.chattingRoomList[index]);
          },
        ),
      ),
    );
  }
}

Widget _chatListItem(ChattingRoomState chattingRoom) {
  navigateToChatScreen(int chatRoomId, String eChatType) {
    Get.toNamed(
      Routes.CHATTING_ROOM,
      arguments: {
        'chatRoomId': chatRoomId,
        'eChatType': eChatType,
      },
    );
  }

  return GestureDetector(
    onTap: () {
      //TODO-[규진] 채팅방으로 이동 동적으로 바꿔야함
      navigateToChatScreen(chattingRoom.chatRoomId, chattingRoom.eChatType);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // 프로필 이미지
          enumToProfileImage(chattingRoom.eChatType),
          const SizedBox(width: 12),
          // 채팅 내용
          _chatContent(chattingRoom.title, chattingRoom.messagePreview),
          const SizedBox(width: 12),
          // 시간과 알림
          _chatTimeAndNotification(
              chattingRoom.createdAt, chattingRoom.nonReadCount),
        ],
      ),
    ),
  );
}

Widget enumToProfileImage(String eChatType) {
  String getImagePath() {
    switch (eChatType) {
      case 'FOLD':
        return 'assets/images/default_npc.png';
      case 'MORNING':
        return 'assets/images/default_npc3.png';
      case 'LUNCH':
        return 'assets/images/default_npc2.png';
      case 'DINNER':
        return 'assets/images/default_npc4.png';
      case 'LEAVE':
        return 'assets/images/default_npc5.png';
      default:
        return 'assets/images/default_npc.png';
    }
  }

  return Container(
    width: 62,
    height: 62,
    decoration: BoxDecoration(
      color: ColorSystem.grey.shade200,
      borderRadius: BorderRadius.circular(31),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(31),
      child: Image.asset(
        getImagePath(),
        fit: BoxFit.contain,
      ),
    ),
  );
}

Widget _chatContent(String name, String preview) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //TODO-[규진] 향후에 실제 데이터로 변경
        Text(
          name,
          style: FontSystem.KR16B,
        ),
        const SizedBox(height: 4),
        Text(
          preview,
          style: FontSystem.KR14R.copyWith(color: Colors.grey[600]),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget _chatTimeAndNotification(String? createdAt, int nonReadCount) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      //TODO-[규진] 향후에 실제 데이터로 변경
      Text(
        createdAt ?? '00:00',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      const SizedBox(height: 4),
      nonReadCount != 0
          ? Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: ColorSystem.blue.shade500,
                shape: BoxShape.circle,
              ),
              child: Center(
                  //TODO-[규진] 향후에 실제 데이터로 변경

                  child: Text(
                nonReadCount.toString(),
                style: TextStyle(
                  color: ColorSystem.white,
                  fontSize: 12,
                ),
              )),
            )
          : Container(),
    ],
  );
}
