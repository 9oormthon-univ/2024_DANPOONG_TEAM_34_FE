import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          const SizedBox(height: 20),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: step == index ? 20 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: step == index
                  ? const Color(0xFF111111)
                  : const Color(0xFFcccccc),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNameInputStep() {
    final formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildTitleName(),
          const SizedBox(
            height: 42,
          ),
          _buildLabelName(),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            cursorHeight: 20,
            onChanged: viewModel.updateName,
            style: FontSystem.KR16M,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '이름을 입력해주세요'; // 유효성 검사 메시지
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "이름을 입력해주세요.",
              hintStyle: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 16,
              ),
              filled: true,
              fillColor: viewModel.isNameValid
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
                color: viewModel.isNameValid
                    ? ColorSystem.blue.shade500
                    : ColorSystem.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: RoundedRectangleTextButton(
                text: '완료',
                textStyle: FontSystem.KR16B.copyWith(
                  color: viewModel.isNameValid
                      ? ColorSystem.white
                      : ColorSystem.grey.shade400,
                ),
                padding: viewModel.isNameValid
                    ? const EdgeInsets.symmetric(vertical: 16)
                    : const EdgeInsets.symmetric(vertical: 2),
                onPressed: viewModel.isNameValid
                    ? () {
                        if (formKey.currentState!.validate()) {
                          // 유효성 검사 통과 시 다음 단계로 이동
                          viewModel.goToNextStep();
                        }
                      }
                    : null,
              ))
        ]),
      ),
    );
  }

  Widget _buildTitleName() {
    return const Column(
      children: [
        Text(
          '안녕하세요!\n당신의 이름을 알려주세요',
          style: FontSystem.KR24B,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLabelName() {
    return const Column(
      children: [
        Text(
          '이름',
          style: FontSystem.KR14R,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildBirthInputStep() {
    final formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildTitleBirth(),
          const SizedBox(
            height: 42,
          ),
          _buildLabelBirth(),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            cursorHeight: 20,
            onChanged: viewModel.updateBirth,
            style: FontSystem.KR16M,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '생년월일을 입력해주세요'; // 유효성 검사 메시지
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "YYYY.MM.DD",
              hintStyle: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 16,
              ),
              filled: true,
              fillColor: viewModel.isBirthValid
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
                color: viewModel.isBirthValid
                    ? ColorSystem.blue.shade500
                    : ColorSystem.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: RoundedRectangleTextButton(
                text: '완료',
                textStyle: FontSystem.KR16B.copyWith(
                  color: viewModel.isBirthValid
                      ? ColorSystem.white
                      : ColorSystem.grey.shade400,
                ),
                padding: viewModel.isBirthValid
                    ? const EdgeInsets.symmetric(vertical: 16)
                    : const EdgeInsets.symmetric(vertical: 2),
                onPressed: viewModel.isBirthValid
                    ? () {
                        if (formKey.currentState!.validate()) {
                          // 유효성 검사 통과 시 다음 단계로 이동
                          viewModel.goToNextStep();
                        }
                      }
                    : null,
              ))
        ]),
      ),
    );
  }

  Widget _buildTitleBirth() {
    return const Column(
      children: [
        Text(
          '생년월일을\n입력해 주세요.',
          style: FontSystem.KR24B,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLabelBirth() {
    return const Column(
      children: [
        Text(
          '생년월일',
          style: FontSystem.KR14R,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildGenderSelectionStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleGender(),
          const SizedBox(height: 42),
          _buildLabelGender(),
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

  Widget _buildTitleGender() {
    return const Column(
      children: [
        Text(
          '성별을\n선택해주세요.',
          style: FontSystem.KR24B,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLabelGender() {
    return const Column(
      children: [
        Text(
          '성별',
          style: FontSystem.KR14R,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMotivateInputStep() {
    final formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildTitleMotivate(),
          const SizedBox(
            height: 42,
          ),
          _buildLabelMotivate(),
          const SizedBox(
            height: 12,
          ),
          TextFormField(
            maxLines: 4,
            maxLength: 200,
            cursorHeight: 20,
            onChanged: viewModel.updateMotivate,
            style: FontSystem.KR16M,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '자기소개를 입력해주세요'; // 유효성 검사 메시지
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "간단한 자기소개와 지원동기를 적어주세요",
              hintStyle: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 16,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              filled: true,
              fillColor: viewModel.isNameValid
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
                color: viewModel.isMotivateValid
                    ? ColorSystem.blue.shade500
                    : ColorSystem.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: RoundedRectangleTextButton(
                text: '이력서 제출하기',
                textStyle: FontSystem.KR16B.copyWith(
                  color: viewModel.isMotivateValid
                      ? ColorSystem.white
                      : ColorSystem.grey.shade400,
                ),
                padding: viewModel.isMotivateValid
                    ? const EdgeInsets.symmetric(vertical: 16)
                    : const EdgeInsets.symmetric(vertical: 2),
                onPressed: (viewModel.isMotivateValid &&
                        viewModel.isBirthValid &&
                        viewModel.isNameValid &&
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
      ),
    );
  }

  Widget _buildTitleMotivate() {
    return const Column(
      children: [
        Text(
          '리부트 오피스의\n지원동기를 적어주세요.',
          style: FontSystem.KR24B,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLabelMotivate() {
    return const Column(
      children: [
        Text(
          '자기소개 및 지원동기',
          style: FontSystem.KR14R,
        ),
        SizedBox(height: 16),
      ],
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
