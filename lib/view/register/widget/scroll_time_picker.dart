import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_widget.dart';
import 'package:rebootOffice/view_model/register/register_view_model.dart';

// class ScrollTimePicker extends BaseWidget<RegisterViewModel> {
//   const ScrollTimePicker({super.key});
//
//   @override
//   Widget buildView(BuildContext context) {
//     return Obx(() {
//       return Container(
//         width: 224,
//         height: 88,
//         decoration: BoxDecoration(
//           color: ColorSystem.lightBlue,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: ColorSystem.Blue),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 70,
//               child: ScrollDateTimePicker(
//                 itemExtent: 54,
//                 infiniteScroll: false,
//                 onChange: (datetime) {
//                   viewModel.updateSelectedHours(datetime);
//                 },
//                 dateOption: DateTimePickerOption(
//                   dateFormat: DateFormat('HH'),
//                   minDate: DateTime(2024),
//                   maxDate: DateTime(2030),
//                   initialDate: viewModel.selectedTimeHours.value,
//                 ),
//                 centerWidget: DateTimePickerCenterWidget(
//                   builder: (context, constraints, child) => const DecoratedBox(
//                     decoration: BoxDecoration(
//                       color: Colors.transparent,
//                     ),
//                   ),
//                 ),
//                 style: DateTimePickerStyle(
//                   activeStyle: FontSystem.KR36B.copyWith(
//                     color: ColorSystem.Blue,
//                   ),
//                   inactiveStyle: const TextStyle(
//                     fontSize: 20,
//                     color: Colors.transparent,
//                   ),
//                   disabledStyle: const TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             Text(
//               ':',
//               style: FontSystem.KR36B.copyWith(
//                 color: ColorSystem.Blue,
//               ),
//             ),
//             SizedBox(
//               width: 70,
//               child: ScrollDateTimePicker(
//                 itemExtent: 54,
//                 infiniteScroll: false,
//                 onChange: (datetime) {
//                   viewModel.updateSelectedMinutes(datetime);
//                 },
//                 dateOption: DateTimePickerOption(
//                   dateFormat: DateFormat('mm'),
//                   minDate: DateTime(2024),
//                   maxDate: DateTime(2030),
//                   initialDate: viewModel.selectedTimeMinutes.value,
//                 ),
//                 centerWidget: DateTimePickerCenterWidget(
//                   builder: (context, constraints, child) => const DecoratedBox(
//                     decoration: BoxDecoration(
//                       color: Colors.transparent,
//                     ),
//                   ),
//                 ),
//                 style: DateTimePickerStyle(
//                   activeStyle: FontSystem.KR36B.copyWith(
//                     color: ColorSystem.Blue,
//                   ),
//                   inactiveStyle: const TextStyle(
//                     fontSize: 20,
//                     color: Colors.transparent,
//                   ),
//                   disabledStyle: const TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
class ScrollTimePicker extends BaseWidget<RegisterViewModel> {
  const ScrollTimePicker({super.key});

  @override
  Widget buildView(BuildContext context) {
    final hoursController = FixedExtentScrollController(initialItem: 1);
    final minutesController = FixedExtentScrollController(initialItem: 0);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      width: 220,
      height: 96,
      decoration: BoxDecoration(
          color: ColorSystem.lightBlue,
          border: Border.all(color: ColorSystem.Blue),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            height: 200,
            child: ListWheelScrollView(
              controller: hoursController,
              physics: const FixedExtentScrollPhysics(),
              itemExtent: 60,
              diameterRatio: 1.5,
              useMagnifier: true,
              magnification: 1,
              onSelectedItemChanged: (index) {
                viewModel.updateSelectedHour(index);
              },
              children: List.generate(
                24,
                (index) => Obx(
                  () => Container(
                    alignment: Alignment.center,
                    child: Text(
                      index.toString().padLeft(2, '0'),
                      style: viewModel.selectedHours == index
                          ? FontSystem.KR36SB.copyWith(color: ColorSystem.black)
                          : FontSystem.KR36SB
                              .copyWith(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(':',
              style: FontSystem.KR36SB.copyWith(color: ColorSystem.black)),
          SizedBox(
            width: 70,
            height: 200,
            child: ListWheelScrollView(
              controller: minutesController,
              physics: const FixedExtentScrollPhysics(),
              itemExtent: 60,
              diameterRatio: 1.5,
              useMagnifier: true,
              magnification: 1,
              onSelectedItemChanged: (index) {
                viewModel.updateSelectedMinute(index);
              },
              children: List.generate(
                60,
                (index) => Obx(() => Container(
                      alignment: Alignment.center,
                      child: Text(
                        index.toString().padLeft(2, '0'),
                        style: viewModel.selectedMinutes == index
                            ? FontSystem.KR36SB
                                .copyWith(color: ColorSystem.black)
                            : FontSystem.KR36SB
                                .copyWith(color: Colors.transparent),
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// 기존 코드
// TODO-[규진] 시연 다 끝나고 다시 돌려두기
// 오전 6시 ~ 9시까지 10분 간격
// class ScrollTimePicker extends BaseWidget<RegisterViewModel> {
//   const ScrollTimePicker({super.key});
//
//   @override
//   Widget buildView(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 32),
//       width: 220,
//       height: 96,
//       decoration: BoxDecoration(
//           color: ColorSystem.lightBlue,
//           border: Border.all(color: ColorSystem.Blue),
//           borderRadius: BorderRadius.circular(16)),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 70,
//             height: 200,
//             child: ListWheelScrollView(
//               physics: const FixedExtentScrollPhysics(),
//               itemExtent: 60,
//               diameterRatio: 1.5,
//               useMagnifier: true,
//               magnification: 1,
//               onSelectedItemChanged: (index) {
//                 viewModel.updateSelectedHour(index + 6);
//               },
//               children: List.generate(
//                 3, // 6시부터 8시까지
//                 (index) => Obx(
//                   () => Container(
//                     alignment: Alignment.center,
//                     child: Text(
//                       (index + 6).toString().padLeft(2, '0'),
//                       style: viewModel.selectedHours == index + 6
//                           ? FontSystem.KR36SB.copyWith(color: ColorSystem.black)
//                           : FontSystem.KR36SB
//                               .copyWith(color: Colors.transparent),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Text(':',
//               style: FontSystem.KR36SB.copyWith(color: ColorSystem.black)),
//           // 분 선택 휠 (수정됨)
//           SizedBox(
//             width: 70,
//             height: 200,
//             child: ListWheelScrollView(
//               physics: const FixedExtentScrollPhysics(),
//               itemExtent: 60,
//               diameterRatio: 1.5,
//               useMagnifier: true,
//               magnification: 1,
//               onSelectedItemChanged: (index) {
//                 viewModel.updateSelectedMinute(index * 10);
//               },
//               children: List.generate(
//                 6, // 00분부터 50분까지 10분 단위
//                 (index) => Obx(() => Container(
//                       alignment: Alignment.center,
//                       child: Text(
//                         (index * 10).toString().padLeft(2, '0'),
//                         style: viewModel.selectedMinutes == index * 10
//                             ? FontSystem.KR36SB
//                                 .copyWith(color: ColorSystem.black)
//                             : FontSystem.KR36SB
//                                 .copyWith(color: Colors.transparent),
//                       ),
//                     )),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
