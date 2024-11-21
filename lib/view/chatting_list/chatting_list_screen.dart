import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view/chatting_room/chatting_room_screen.dart';
import 'package:rebootOffice/view_model/chatting_list/chatting_list_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';

class ChattingListScreen extends BaseScreen<ChattingListViewModel> {
  const ChattingListScreen({super.key});

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
        ));
  }

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5, // 채팅 리스트 아이템 개수
              itemBuilder: (context, index) {
                return _chatListItem();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _chatListItem() {
  _navigateToChatScreen() {
    Get.to(
      () => ChattingRoomScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  return GestureDetector(
    onTap: () {
      //TODO-[규진] 채팅방으로 이동 동적으로 바꿔야함
      _navigateToChatScreen();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // 프로필 이미지
          _profileImage(),
          const SizedBox(width: 12),
          // 채팅 내용
          _chatContent(),
          const SizedBox(width: 12),
          // 시간과 알림
          _chatTimeAndNotification(),
        ],
      ),
    ),
  );
}

Widget _profileImage() {
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
        'assets/images/default_npc.png',
        fit: BoxFit.contain,
      ),
    ),
  );
}

Widget _chatContent() {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //TODO-[규진] 향후에 실제 데이터로 변경
        const Text(
          '일상회복팀 리부트대리',
          style: FontSystem.KR16B,
        ),
        const SizedBox(height: 4),
        Text(
          '안녕하세요 회군인턴님 일상화복팀 리부트트트트대리입니다. 오늘은 어떤 일이 있으셨나요?',
          style: FontSystem.KR14R.copyWith(color: Colors.grey[600]),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget _chatTimeAndNotification() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      //TODO-[규진] 향후에 실제 데이터로 변경
      Text(
        '18:30',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      const SizedBox(height: 4),
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: ColorSystem.blue.shade500,
          shape: BoxShape.circle,
        ),
        child: const Center(
          //TODO-[규진] 향후에 실제 데이터로 변경

          child: Text(
            '1',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    ],
  );
}
