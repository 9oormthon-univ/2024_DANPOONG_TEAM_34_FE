import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view/onboarding/component/gender_selection.dart';
import 'package:rebootOffice/view/onboarding/onboarding_load_screen.dart';
import 'package:rebootOffice/view_model/onboarding/onboarding_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';

class OnboardingScreen extends BaseScreen<OnboardingViewModel> {
  const OnboardingScreen({super.key});

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  bool get setBottomInnerSafeArea => true;

  @override
  Color? get screenBackgroundColor => Colors.white;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: DefaultSvgAppBar(
          svgPath: 'assets/icons/appbar/header-logo.svg',
          height: 15,
        ));
  }

  @override
  Widget buildBody(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          // 페이지네이션 바
          _buildPaginationIndicator(viewModel.currentPageIndex),
          const SizedBox(height: 24),
          // PageView로 컨텐츠 렌더링
          Expanded(
            child: PageView(
              controller: viewModel.pageController, // PageController 연결
              onPageChanged: (index) {
                viewModel.currentPageIndex = index; // ViewModel과 동기화
              },
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildNameInputStep(),
                _buildBirthInputStep(),
                _buildGenderSelectionStep(),
                _buildMotivateInputStep(),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildPaginationIndicator(int step) {
    const int totalSteps = 4; // 총 단계 수
    return LinearProgressBar(
      maxSteps: totalSteps, // 총 단계 설정
      currentStep: step + 1, // 현재 단계 (0부터 시작하므로 +1)
      progressColor: ColorSystem.Blue, // 진행된 부분 색상
      backgroundColor: ColorSystem.lightBlue, // 배경 색상
      minHeight: 5.0, // ProgressBar의 높이
      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF111111)),
    );
  }

  Widget _buildNameInputStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildTitle('안녕하세요!\n당신의 이름을 알려주세요'),
        _buildLabel('이름'),
        TextField(
          cursorHeight: 20,
          controller: viewModel.textController,
          style: FontSystem.KR16M,
          decoration: InputDecoration(
            hintText: "이름을 입력해주세요.",
            hintStyle:
                FontSystem.KR16B.copyWith(color: ColorSystem.grey.shade600),
            filled: true,
            fillColor: viewModel.textController.text.isNotEmpty
                ? ColorSystem.lightBlue
                : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFFE5E5EC),
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFFE5E5EC), // 활성 상태 테두리 색상
                width: 1.0, // 테두리 두께
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: ColorSystem.Blue, // 포커스 상태 테두리 색상 (예: 파란색)
                width: 1.0, // 포커스 상태 테두리 두께
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        _buildLabel('영문 이름'),
        TextField(
          cursorHeight: 20,
          controller: viewModel.textEnController,
          style: FontSystem.KR16M,
          decoration: InputDecoration(
            hintText: "영문 이름을 입력해주세요.",
            hintStyle:
                FontSystem.KR16B.copyWith(color: ColorSystem.grey.shade600),
            filled: true,
            fillColor: viewModel.textEnController.text.isNotEmpty
                ? ColorSystem.lightBlue
                : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFFE5E5EC),
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFFE5E5EC), // 활성 상태 테두리 색상
                width: 1.0, // 테두리 두께
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: ColorSystem.Blue, // 포커스 상태 테두리 색상 (예: 파란색)
                width: 1.0, // 포커스 상태 테두리 두께
              ),
            ),
          ),
        ),
        const Spacer(),
        Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: viewModel.isNameButtonEnabled
                  ? ColorSystem.blue.shade500
                  : ColorSystem.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: RoundedRectangleTextButton(
              text: '완료',
              textStyle: FontSystem.KR16B.copyWith(
                color: viewModel.isNameButtonEnabled
                    ? ColorSystem.white
                    : ColorSystem.grey.shade400,
              ),
              padding: viewModel.isNameButtonEnabled
                  ? const EdgeInsets.symmetric(vertical: 16)
                  : const EdgeInsets.symmetric(vertical: 2),
              onPressed: viewModel.isNameButtonEnabled
                  ? () {
                      viewModel.goToNextStep();
                    }
                  : null,
            ))
      ]),
    );
  }

  Widget _buildTitle(String text) {
    return Column(
      children: [
        Text(
          text,
          style: FontSystem.KR24B,
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return Column(
      children: [
        Text(
          label,
          style: FontSystem.KR14R,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildBirthInputStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildTitle('생년월일을\n입력해 주세요.'),
        _buildLabel('생년월일'),
        const SizedBox(
          height: 12,
        ),
        TextField(
          cursorHeight: 20,
          controller: viewModel.textBirthController,
          style: FontSystem.KR16M,
          decoration: InputDecoration(
            hintText: "YYYY.MM.DD",
            hintStyle: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 16,
            ),
            filled: true,
            fillColor: viewModel.textBirthController.text.isNotEmpty
                ? const Color(0xFFE5F0FF)
                : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFFE5E5EC),
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFFE5E5EC), // 활성 상태 테두리 색상
                width: 1.0, // 테두리 두께
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFF0066ff), // 포커스 상태 테두리 색상 (예: 파란색)
                width: 1.0, // 포커스 상태 테두리 두께
              ),
            ),
          ),
        ),
        const Spacer(),
        Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: viewModel.isBirthButtonEnabled
                  ? ColorSystem.blue.shade500
                  : ColorSystem.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: RoundedRectangleTextButton(
              text: '완료',
              textStyle: FontSystem.KR16B.copyWith(
                color: viewModel.isBirthButtonEnabled
                    ? ColorSystem.white
                    : ColorSystem.grey.shade400,
              ),
              padding: viewModel.isBirthButtonEnabled
                  ? const EdgeInsets.symmetric(vertical: 16)
                  : const EdgeInsets.symmetric(vertical: 2),
              onPressed: viewModel.isBirthButtonEnabled
                  ? () {
                      viewModel.goToNextStep();
                    }
                  : null,
            ))
      ]),
    );
  }

  Widget _buildGenderSelectionStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle('성별을\n선택해주세요.'),
          _buildLabel('성별'),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => viewModel.selectGender('남성'),
                child: GenderSelection(
                  isSelected: viewModel.selectedGender == '남성',
                  selector: '남성',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () => viewModel.selectGender('여성'),
                child: GenderSelection(
                  isSelected: viewModel.selectedGender == '여성',
                  selector: '여성',
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: viewModel.selectedGender != null
                    ? ColorSystem.blue.shade500
                    : ColorSystem.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: RoundedRectangleTextButton(
                text: '완료',
                textStyle: FontSystem.KR16B.copyWith(
                  color: viewModel.selectedGender != null
                      ? ColorSystem.white
                      : ColorSystem.grey.shade400,
                ),
                padding: viewModel.selectedGender != null
                    ? const EdgeInsets.symmetric(vertical: 16)
                    : const EdgeInsets.symmetric(vertical: 2),
                onPressed: viewModel.selectedGender != null
                    ? () {
                        viewModel.goToNextStep();
                      }
                    : null,
              ))
        ],
      ),
    );
  }

  Widget _buildMotivateInputStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildTitle('리부트 오피스의\n지원동기를 적어주세요.'),
        _buildLabel('자기소개 및 지원동기'),
        TextField(
          maxLines: 4,
          maxLength: 200,
          cursorHeight: 20,
          controller: viewModel.textMotivateController,
          style: FontSystem.KR16M,
          decoration: InputDecoration(
            hintText: "간단한 자기소개와 지원동기를 적어주세요",
            hintStyle: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 16,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            filled: true,
            fillColor: viewModel.textMotivateController.text.isNotEmpty
                ? const Color(0xFFE5F0FF)
                : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFFE5E5EC),
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFFE5E5EC), // 활성 상태 테두리 색상
                width: 1.0, // 테두리 두께
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFF0066ff), // 포커스 상태 테두리 색상 (예: 파란색)
                width: 1.0, // 포커스 상태 테두리 두께
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        _buildExample(),
        const Spacer(),
        Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: viewModel.isMotivateButtonEnabled
                  ? ColorSystem.blue.shade500
                  : ColorSystem.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: RoundedRectangleTextButton(
              text: '이력서 제출하기',
              textStyle: FontSystem.KR16B.copyWith(
                color: viewModel.isMotivateButtonEnabled
                    ? ColorSystem.white
                    : ColorSystem.grey.shade400,
              ),
              padding: viewModel.isMotivateButtonEnabled
                  ? const EdgeInsets.symmetric(vertical: 16)
                  : const EdgeInsets.symmetric(vertical: 2),
              onPressed: (viewModel.isMotivateButtonEnabled &&
                      viewModel.isBirthButtonEnabled &&
                      viewModel.isNameButtonEnabled &&
                      viewModel.selectedGender != null)
                  ? () {
                      Get.to(
                        () => const OnboardingLoadScreen(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 300),
                      );
                    }
                  : null,
            ))
      ]),
    );
  }

  Widget _buildExample() {
    return ExpansionTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // 둥근 모서리
        side: const BorderSide(color: Color(0xFFE5E5EC), width: 1), // 테두리 색과 두께
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // 둥근 모서리
        side: const BorderSide(color: Color(0xFFE5E5EC), width: 1), // 테두리 색과 두께
      ),
      title: const Text(
        '무엇을 적어야 할지 고민되시나요?',
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF767676), // 글자색
        ),
      ),
      childrenPadding: const EdgeInsets.all(16),
      trailing: const Icon(
        Icons.expand_more,
        color: Color(0xFF767676), // 아이콘 색
      ), // 펼쳐진 영역의 padding
      children: const [
        Text(
          '본인의 특징, 좋아하는 것, 관심 있는 분야를\n간단히 이야기해 보고 이곳에서 하고 싶은 일이나 이루고 싶은 목표를 적어 보세요.',
          style: TextStyle(fontSize: 14, color: Color(0xFF555555)),
        ),
      ],
    );
  }
}
