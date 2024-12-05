import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:rebootOffice/utility/functions/log_util.dart';
import 'package:rebootOffice/utility/functions/on_boarding_util.dart';
import 'package:rebootOffice/utility/static/app_routes.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view/register/component/multi_select_box.dart';
import 'package:rebootOffice/view/register/component/select_box.dart';
import 'package:rebootOffice/view/register/widget/scroll_time_picker.dart';
import 'package:rebootOffice/view_model/register/register_view_model.dart';
import 'package:rebootOffice/widget/appbar/default_svg_appbar.dart';
import 'package:rebootOffice/widget/button/rounded_rectangle_text_button.dart';

class RegisterScreen extends BaseScreen<RegisterViewModel> {
  const RegisterScreen({super.key});

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
        ));
  }

  @override
  Widget buildBody(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          // 페이지네이션 바
          _buildPaginationIndicator(viewModel.currentPageIndex),
          const SizedBox(height: 32),
          // PageView로 컨텐츠 렌더링
          Expanded(
            child: PageView(
              controller: viewModel.pageController,
              onPageChanged: (index) {
                viewModel.currentPageIndex = index;
              },
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildFirstPage(),
                _buildSecondPage(),
                _buildThirdPage(),
                _buildFourthPage(),
                _buildFifthPage(),
                _buildComfirmPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationIndicator(int step) {
    const int totalSteps = 6; // 총 단계 수
    return LinearProgressBar(
      maxSteps: totalSteps, // 총 단계 설정
      currentStep: step + 1, // 현재 단계 (0부터 시작하므로 +1)
      progressColor: ColorSystem.Blue, // 진행된 부분 색상
      backgroundColor: ColorSystem.lightBlue, // 배경 색상
      minHeight: 5.0, // ProgressBar의 높이
      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF111111)),
    );
  }

  Widget _buildFirstPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SvgPicture.asset(
              'assets/images/profile_npc.svg',
              width: 200,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          _buildTitle(viewModel.displayText.value),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: viewModel.isAnimating
                  ? ColorSystem.grey.shade200
                  : ColorSystem.blue.shade500,
              borderRadius: BorderRadius.circular(12),
            ),
            child: RoundedRectangleTextButton(
              text: '다음',
              textStyle: FontSystem.KR16B.copyWith(
                color: viewModel.isAnimating
                    ? ColorSystem.grey.shade400
                    : ColorSystem.white,
              ),
              padding: viewModel.isAnimating
                  ? const EdgeInsets.symmetric(vertical: 2)
                  : const EdgeInsets.symmetric(vertical: 16),
              onPressed: !viewModel.isAnimating
                  ? () {
                      viewModel.goToNextStep();
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SvgPicture.asset(
              'assets/images/profile_npc.svg',
              width: 200,
            ),
          ),
          const SizedBox(height: 28),
          _buildTitle('근무가능 기간을 알려주세요!'),
          const SizedBox(height: 8),
          _buildLabel('선택하신 기간 동안 저희 회사에 입사하셔서\n다양한 미션을 수행하시게 됩니다.'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => viewModel.selectWork('1주'),
                    child: SelectBox(
                      isSelected: viewModel.selectedWork == '1주',
                      selector: '1주',
                      isCenter: true,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => viewModel.selectWork('2주'),
                    child: SelectBox(
                      isSelected: viewModel.selectedWork == '2주',
                      selector: '2주',
                      isCenter: true,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => viewModel.selectWork('3주'),
                    child: SelectBox(
                      isSelected: viewModel.selectedWork == '3주',
                      selector: '3주',
                      isCenter: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: viewModel.isSelectWork
                  ? ColorSystem.blue.shade500
                  : ColorSystem.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: RoundedRectangleTextButton(
              text: '다음',
              textStyle: FontSystem.KR16B.copyWith(
                color: viewModel.isSelectWork
                    ? ColorSystem.white
                    : ColorSystem.grey.shade400,
              ),
              padding: viewModel.isSelectWork
                  ? const EdgeInsets.symmetric(vertical: 16)
                  : const EdgeInsets.symmetric(vertical: 2),
              onPressed: viewModel.isSelectWork
                  ? () {
                      viewModel.goToNextStep();
                    }
                  : null,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildThirdPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SvgPicture.asset(
                  'assets/images/profile_npc.svg',
                  width: 200,
                ),
              ),
              const SizedBox(height: 28),
              _buildTitle('몇 시까지 출근하시겠어요?'),
              const SizedBox(height: 8),
              _buildLabel('선택하신 시간에 기상하셔서 기상 인증\n미션을 진행하게 됩니다'),
              const SizedBox(
                height: 24,
              ),
              const ScrollTimePicker(),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: ColorSystem.blue.shade500,
                borderRadius: BorderRadius.circular(12),
              ),
              child: RoundedRectangleTextButton(
                  text: '다음',
                  textStyle: FontSystem.KR16B.copyWith(
                    color: ColorSystem.white,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  onPressed: () {
                    viewModel.goToNextStep();
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFourthPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SvgPicture.asset('assets/images/profile_npc.svg',
                    width: 120, height: 120, fit: BoxFit.cover),
              ),
              const SizedBox(height: 20),
              _buildTitle('가능한 업무 영역은 어떻게 되나요?'),
              const SizedBox(height: 8),
              _buildLabel('선택하신 업무 범위를 기준으로\n미션이 부여됩니다'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "규칙적인 식사",
                  style: FontSystem.KR16B,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 4,
                ),
                Obx(
                  () => Column(
                    children: viewModel.options.map((option) {
                      final isSelected =
                          viewModel.selectedItems.contains(option);
                      return GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            viewModel.selectedItems.remove(option);
                          } else {
                            viewModel.selectedItems.add(option);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: MultiSelectBox(
                            selector: option,
                            isSelected: isSelected,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: viewModel.selectedItems.isNotEmpty
                  ? ColorSystem.blue.shade500
                  : ColorSystem.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: RoundedRectangleTextButton(
              text: '다음',
              textStyle: FontSystem.KR16B.copyWith(
                color: viewModel.selectedItems.isNotEmpty
                    ? ColorSystem.white
                    : ColorSystem.grey.shade400,
              ),
              padding: viewModel.selectedItems.isNotEmpty
                  ? const EdgeInsets.symmetric(vertical: 16)
                  : const EdgeInsets.symmetric(vertical: 2),
              onPressed: viewModel.selectedItems.isNotEmpty
                  ? () {
                      viewModel.goToNextStep();
                    }
                  : null,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFifthPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SvgPicture.asset('assets/images/profile_npc.svg',
                    width: 120, height: 120, fit: BoxFit.cover),
              ),
              const SizedBox(height: 20),
              _buildTitle('가능한 업무 영역은 어떻게 되나요?'),
              const SizedBox(height: 8),
              _buildLabel('선택하신 업무 범위를 기준으로\n미션이 부여됩니다'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "외근 가능 여부",
                  style: FontSystem.KR16B,
                  textAlign: TextAlign.start,
                ),
                Text(
                  "가벼운 외출이나 산책이 가능 하신가요?",
                  style:
                      FontSystem.KR14R.copyWith(color: const Color(0XFF999999)),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => viewModel.selectWorkPlace('네, 외근에 도전해보겠습니다!'),
                  child: SelectBox(
                    isSelected:
                        viewModel.selectedWorkPlace == '네, 외근에 도전해보겠습니다!',
                    selector: '네, 외근에 도전해보겠습니다!',
                    isCenter: true,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => viewModel.selectWorkPlace('아직은 조금 어려울 것 같아요'),
                  child: SelectBox(
                    isSelected:
                        viewModel.selectedWorkPlace == '아직은 조금 어려울 것 같아요',
                    selector: '아직은 조금 어려울 것 같아요',
                    isCenter: true,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: viewModel.isSelectWorkPlace
                  ? ColorSystem.blue.shade500
                  : ColorSystem.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: RoundedRectangleTextButton(
              text: '다음',
              textStyle: FontSystem.KR16B.copyWith(
                color: viewModel.isSelectWorkPlace
                    ? ColorSystem.white
                    : ColorSystem.grey.shade400,
              ),
              padding: viewModel.isSelectWorkPlace
                  ? const EdgeInsets.symmetric(vertical: 16)
                  : const EdgeInsets.symmetric(vertical: 2),
              onPressed: viewModel.isSelectWorkPlace
                  ? () {
                      viewModel.goToNextStep();
                    }
                  : null,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildComfirmPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/profile_npc.svg',
                width: 200,
              ),
              const SizedBox(height: 28),
              _buildTitle('근로계약서 작성이 완료되었습니다'),
              const SizedBox(height: 8),
              _buildLabel(
                  '앞으로 리부트 오피스와 함께하는 나날들이\n여러분의 삶에 소중한 변화와\n성장을 선물하길 바랍니다'),
            ],
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: ColorSystem.blue.shade500,
              borderRadius: BorderRadius.circular(12),
            ),
            child: RoundedRectangleTextButton(
              text: '리부트 오피스 시작하기',
              textStyle: FontSystem.KR16B.copyWith(color: ColorSystem.white),
              padding: viewModel.isSelectWorkPlace
                  ? const EdgeInsets.symmetric(vertical: 16)
                  : const EdgeInsets.symmetric(vertical: 2),
              onPressed: () async {
                await completeOnboarding();
                await viewModel.submitRegisterData();
                Get.offAllNamed(Routes.ROOT);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: FontSystem.KR24EB,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: FontSystem.KR16R.copyWith(color: ColorSystem.grey.shade600),
      textAlign: TextAlign.center,
    );
  }
}
