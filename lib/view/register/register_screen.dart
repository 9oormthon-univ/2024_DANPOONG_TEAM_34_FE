import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_screen.dart';
import 'package:rebootOffice/view/register/component/multi_select_box.dart';
import 'package:rebootOffice/view/register/component/select_box.dart';
import 'package:rebootOffice/view/register/widget/aniamted_text_widget.dart';
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
          _buildPaginationIndicator(viewModel.currentPage),
          const SizedBox(height: 32),
          // PageView로 컨텐츠 렌더링
          Expanded(
            child: PageView(
              controller: viewModel.pageController,
              onPageChanged: (index) {
                viewModel.currentPage = index;
              },
              children: [
                // _buildFirstPage(),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: step == index ? 20 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: step == index
                  ? const Color(0xFF111111)
                  : const Color(0xFFcccccc),
              borderRadius: BorderRadius.circular(16), // 둥근 모서리
              shape: BoxShape.rectangle,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFirstPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/npc_profile.png'),
        const SizedBox(
          height: 32,
        ),
        AnimatedTextWidget(
          text: controller.currentTexts[controller.currentTextIndex],
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {},
          child: const Text('다음'),
        ),
      ],
    );
  }

  Widget _buildSecondPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/profile_npc.png'),
          const SizedBox(height: 28),
          const Text(
            '근무가능 기간을 알려주세요!',
            style: FontSystem.KR24EB,
          ),
          const SizedBox(height: 8),
          Text(
            '선택하신 기간 동안 저희 회사에 입사하셔서\n다양한 미션을 수행하시게 됩니다.',
            style: FontSystem.KR16R.copyWith(color: const Color(0xFF999999)),
            textAlign: TextAlign.center,
          ),
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
                      //TODO-[지희] 다음 페이지 이동
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
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/profile_npc.png'),
              const SizedBox(height: 28),
              const Text(
                '몇 시까지 출근하시겠어요?',
                style: FontSystem.KR24EB,
              ),
              const SizedBox(height: 8),
              Text(
                '선택하신 시간에 기상하셔서 기상 인증\n미션을 진행하게 됩니다',
                style:
                    FontSystem.KR16R.copyWith(color: const Color(0xFF999999)),
                textAlign: TextAlign.center,
              ),
              // const ScrollTimePicker(),
            ],
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/profile_npc.png',
                  width: 120, height: 120, fit: BoxFit.cover),
              const SizedBox(height: 28),
              const Text(
                '가능한 업무 영역은 어떻게 되나요?',
                style: FontSystem.KR24EB,
              ),
              const SizedBox(height: 8),
              Text(
                '선택하신 업무 범위를 기준으로\n미션이 부여됩니다',
                style:
                    FontSystem.KR16R.copyWith(color: const Color(0xFF999999)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "규칙적인 식사",
                  style: FontSystem.KR16B,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 16,
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
                          padding: const EdgeInsets.symmetric(vertical: 8),
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
                      //TODO-[지희] 다음 페이지 이동
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/profile_npc.png',
                  width: 120, height: 120, fit: BoxFit.cover),
              const SizedBox(height: 28),
              const Text(
                '가능한 업무 영역은 어떻게 되나요?',
                style: FontSystem.KR24EB,
              ),
              const SizedBox(height: 8),
              Text(
                '선택하신 업무 범위를 기준으로\n미션이 부여됩니다',
                style:
                    FontSystem.KR16R.copyWith(color: const Color(0xFF999999)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
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
              onPressed: viewModel.isSelectWork
                  ? () {
                      //TODO-[지희] 다음 페이지 이동
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
            children: [
              Image.asset('assets/images/profile_npc.png'),
              const SizedBox(height: 28),
              const Text(
                '근로계약서 작성이 완료되었습니다',
                style: FontSystem.KR24EB,
              ),
              const SizedBox(height: 8),
              Text(
                '앞으로 리부트 오피스와 함께하는 나날들이\n여러분의 삶에 소중한 변화와\n성장을 선물하길 바랍니다',
                style:
                    FontSystem.KR16R.copyWith(color: const Color(0xFF999999)),
                textAlign: TextAlign.center,
              ),
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
                onPressed: () {
                  //TODO-[지희] 다음 페이지 이동
                }),
          ),
        ],
      ),
    );
  }
}
