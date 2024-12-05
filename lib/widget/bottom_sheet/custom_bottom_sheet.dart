import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_widget.dart';
import 'package:rebootOffice/view_model/chatting_room/chatting_room_view_model.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';

/// 이 부분 테스트 할 때는 항상 Release 모드로, 실기기로 테스트 해야함
/// Camera 권한을 받기 위해서는 어쩔 수 없이 Release 모드로 테스트 해야함
/// @author 홍규진
///
void showReportBottomSheet(BuildContext context) {
  Get.bottomSheet(
    const ReportBottomSheet(),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    enableDrag: true, // 드래그 가능하도록 설정
  );
}

class ReportBottomSheet extends BaseWidget<ChattingRoomViewModel> {
  const ReportBottomSheet({super.key});

  @override
  Widget buildView(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            color: ColorSystem.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(24),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                _buildImageSection(),
                viewModel.hasImage
                    ? _buildContentSection(context)
                    : const SizedBox(),
                _buildSubmitSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '업무 보고 사진을 촬영해주세요',
          style: FontSystem.KR18B,
        ),
        const SizedBox(height: 8),
        Text(
          '현재 진행 중인 업무 상황에서 직접 촬영한\n사진만 업무 보고용으로 제출 가능합니다.',
          style: FontSystem.KR14R.copyWith(
            color: ColorSystem.grey.shade600,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildImageSection() {
    return GestureDetector(
      onTap: viewModel.checkAndRequestCameraPermission,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16), // 위아래 여백 추가
            padding: viewModel.imageFile == null
                ? null
                : const EdgeInsets.all(8), // 내부 여백 추가
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // 모서리 둥글게
              color: viewModel.imageFile == null
                  ? Colors.transparent
                  : Colors.grey[100], // 배경색 추가 (선택사항)
            ),
            child: viewModel.hasImage
                ? Image.file(
                    viewModel.imageFile!,
                    fit: BoxFit.cover,
                    width: Get.width * 0.3,
                  )
                : null,
          ),
          RoundedRectangleTextButton(
            width: Get.width,
            onPressed: viewModel.checkAndRequestCameraPermission,
            text: viewModel.imageFile == null ? '사진 촬영하기' : '다시 촬영하기',
            textStyle: viewModel.imageFile == null
                ? FontSystem.KR16B.copyWith(
                    color: ColorSystem.white,
                  )
                : FontSystem.KR16B.copyWith(
                    color: ColorSystem.blue.shade500,
                  ),
            padding: const EdgeInsets.symmetric(vertical: 18),
            backgroundColor: viewModel.imageFile == null
                ? ColorSystem.blue.shade500
                : ColorSystem.grey.shade200,
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        const Text(
          '이번 업무에 대해서 소개해주세요!',
          style: FontSystem.KR24B,
        ),
        const SizedBox(height: 8),
        Text(
          '업무 중 느낀 점이나 기록하고 싶은 내용을 적어주세요.\n나중에 통계에서 확인할 수 있어요',
          style: FontSystem.KR14R.copyWith(
            color: ColorSystem.grey.shade600,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: viewModel.contentController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: '업무의 내용을 간단하게 기록해주세요',
              hintStyle: FontSystem.KR14R.copyWith(
                color: ColorSystem.grey.shade400,
              ),
              fillColor: ColorSystem.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: ColorSystem.grey.shade400,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSubmitSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: viewModel.hasImage
            ? ColorSystem.blue.shade500
            : ColorSystem.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: viewModel.hasImage
          ? RoundedRectangleTextButton(
              text: '업무 보고하기',
              textStyle: FontSystem.KR16B.copyWith(
                color: viewModel.hasImage
                    ? ColorSystem.white
                    : ColorSystem.grey.shade400,
              ),
              padding: viewModel.hasImage
                  ? const EdgeInsets.symmetric(vertical: 16)
                  : const EdgeInsets.symmetric(vertical: 2),
              onPressed: viewModel.hasImage
                  ? () {
                      viewModel.sendMessage(viewModel.chatRoomId);
                      Get.back();
                    }
                  : null,
            )
          : null,
    );
  }
}
