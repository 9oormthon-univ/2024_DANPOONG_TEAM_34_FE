import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_widget.dart';
import 'package:rebootOffice/view_model/register/register_view_model.dart';

class ScrollTimePicker extends BaseWidget<RegisterViewModel> {
  const ScrollTimePicker({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Obx(
              () => ListWheelScrollView.useDelegate(
                itemExtent: 100,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  viewModel.updateHour(index); // selectedHour 업데이트
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    return Center(
                      child: Text(
                        '$index',
                        style: FontSystem.KR32B,
                      ),
                    );
                  },
                  childCount: 25, // 시간: 0 ~ 24
                ),
              ),
            ),
            const Text(':', style: FontSystem.KR32B), // ":" 구분자
            // 분 선택 위젯
            Obx(() {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50, // 배경색 설정
                  borderRadius: BorderRadius.circular(8), // 둥근 모서리
                  border: Border.all(color: Colors.blue), // 테두리
                ),
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 100,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    viewModel.updateMinute(index); // selectedMinute 업데이트
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      return Center(
                        child: Text(
                          index.toString().padLeft(2, '0'), // 두 자릿수로 표시
                          style: FontSystem.KR32B,
                        ),
                      );
                    },
                    childCount: 60, // 분: 0 ~ 59
                  ),
                ),
              );
            }),
          ],
        )
      ],
    );
  }
}
