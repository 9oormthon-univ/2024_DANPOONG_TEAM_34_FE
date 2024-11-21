import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view/onboarding/component/gender_selection.dart';
import 'package:rebootOffice/view/onboarding/component/onboarding_label.dart';
import 'package:rebootOffice/view/onboarding/component/onboarding_title.dart';
import 'package:rebootOffice/view_model/onboarding/onboarding_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(4, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: step == index
                  ? const Color(0xFF111111)
                  : const Color(0xFFcccccc),
              shape: BoxShape.circle,
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
          const OnboardingTitle(title: '안녕하세요!\n당신의 이름을 알려주세요.'),
          const SizedBox(
            height: 42,
          ),
          const OnboardingLabel(label: '이름'),
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
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // 유효성 검사 통과 시 다음 단계로 이동
                  viewModel.goToNextStep();
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF0C1C56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // 둥근 모서리
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0), // 내부 여백
              ),
              child: const Text("완료"),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildBirthInputStep() {
    final formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const OnboardingTitle(title: '생년월일을\n입력해 주세요.'),
          const SizedBox(
            height: 42,
          ),
          const OnboardingLabel(label: '생년월일'),
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
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // 유효성 검사 통과 시 다음 단계로 이동
                  viewModel.goToNextStep();
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF0C1C56), // 버튼 텍스트 색상 (예: 흰색)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // 둥근 모서리
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0), // 내부 여백
              ),
              // .copyWith(
              //   // 비활성화 상태의 스타일
              //   surfaceTintColor: WidgetStateProperty.all(
              //       const Color(0xFF999999)), // 비활성화된 상태의 텍스트 색상 (예: 회색)
              //   backgroundColor: WidgetStateProperty.all(
              //       const Color(0xFFF1F1F5)), // 비활성화된 상태의 배경색 (예: 밝은 회색)
              //   side: WidgetStateProperty.all(
              //     const BorderSide(
              //         color: Color(0xFFE5E5EC)), // 비활성화 상태의 테두리 색상 (예: 연한 회색)
              //   ),
              // ),
              child: const Text("완료"),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildGenderSelectionStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingTitle(title: '성별을 선택해주세요.'),
          const SizedBox(height: 42),
          const OnboardingLabel(label: '성별'),
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
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: viewModel.selectedGender != null
                  ? () => viewModel.goToNextStep()
                  : null, // 성별 선택 안 된 경우 버튼 비활성화
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF0C1C56), // 버튼 텍스트 색상 (예: 흰색)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // 둥근 모서리
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0), // 내부 여백
              ),
              // .copyWith(
              //   // 비활성화 상태의 스타일
              //   surfaceTintColor: WidgetStateProperty.all(
              //       const Color(0xFF999999)), // 비활성화된 상태의 텍스트 색상 (예: 회색)
              //   backgroundColor: WidgetStateProperty.all(
              //       const Color(0xFFF1F1F5)), // 비활성화된 상태의 배경색 (예: 밝은 회색)
              //   side: WidgetStateProperty.all(
              //     const BorderSide(
              //         color: Color(0xFFE5E5EC)), // 비활성화 상태의 테두리 색상 (예: 연한 회색)
              //   ),
              // ),
              child: const Text("완료"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMotivateInputStep() {
    final formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const OnboardingTitle(title: '안녕하세요!\n당신의 이름을 알려주세요.'),
          const SizedBox(
            height: 42,
          ),
          const OnboardingLabel(label: '이름'),
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
          ExpansionTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // 둥근 모서리
              side: const BorderSide(
                  color: Color(0xFFE5E5EC), width: 1), // 테두리 색과 두께
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // 둥근 모서리
              side: const BorderSide(
                  color: Color(0xFFE5E5EC), width: 1), // 테두리 색과 두께
            ),
            title: const Text(
              '예시 질문을 확인해 보세요',
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
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // 유효성 검사 통과 시 다음 단계로 이동
                  // onboarding_load_screen으로 이동
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF0C1C56), // 버튼 텍스트 색상 (예: 흰색)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // 둥근 모서리
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0), // 내부 여백
              ),
              child: const Text(
                "이력서 제출하기",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
