import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/static/app_routes.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_widget.dart';
import 'package:rebootOffice/view_model/chatting_list/chatting_room_list_view_model.dart';
import 'package:rebootOffice/view_model/home/home_view_model.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';

class WelcomeCard extends BaseWidget<ChattingRoomListViewModel> {
  const WelcomeCard({super.key});

  @override
  Widget buildView(BuildContext context) {
    final homeViewModel = Get.find<HomeViewModel>();
    return Obx(() {
      // 모든 채팅방의 nonReadCount 합계 계산
      final totalUnreadCount = viewModel.chattingRoomList
          .fold(0, (sum, room) => sum + room.nonReadCount);

      // EndTime+1 이면 다른 컨테이너 반환
      if (homeViewModel.isNextDay()) {
        return Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.only(top: 24),
          decoration: BoxDecoration(
            color: ColorSystem.white,
            border: Border.all(color: ColorSystem.grey.shade200, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/default_npc.png',
                  width: 132,
                  height: 132,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '센터 전문의와 앞으로의 방향을 정해볼까요?',
                style: FontSystem.KR16EB.copyWith(color: ColorSystem.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: RoundedRectangleTextButton(
                  onPressed: () {
                    // 엔딩스크린으로 이동
                    Get.toNamed(Routes.ENDING);
                  },
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  text: '지원센터 바로가기',
                  textStyle:
                      FontSystem.KR16B.copyWith(color: ColorSystem.white),
                  backgroundColor: ColorSystem.blue.shade500,
                ),
              ),
            ],
          ),
        );
      }

      // unread 메시지가 없으면 빈 컨테이너 반환
      if (totalUnreadCount == 0) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
          color: ColorSystem.white,
          border: Border.all(color: ColorSystem.grey.shade200, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Image.asset(
                'assets/images/default_npc.png',
                width: 132,
                height: 132,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '확인하지 않은 메시지가 있어요!',
              style: FontSystem.KR16EB.copyWith(color: ColorSystem.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: RoundedRectangleTextButton(
                onPressed: () {
                  viewModel.selectBottomBarIndex(1);
                },
                padding: const EdgeInsets.symmetric(vertical: 12),
                text: '채팅 확인하러 가기',
                textStyle: FontSystem.KR16B.copyWith(color: ColorSystem.white),
                backgroundColor: ColorSystem.blue.shade500,
              ),
            ),
          ],
        ),
      );
    });
  }
}
