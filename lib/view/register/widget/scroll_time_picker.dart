import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:rebootOffice/utility/system/color_system.dart';
import 'package:rebootOffice/utility/system/font_system.dart';
import 'package:rebootOffice/view/base/base_widget.dart';
import 'package:rebootOffice/view_model/register/register_view_model.dart';
import 'package:scroll_datetime_picker/scroll_datetime_picker.dart';

class ScrollTimePicker extends BaseWidget<RegisterViewModel> {
  const ScrollTimePicker({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(() {
      return Container(
        width: 224,
        height: 88,
        decoration: BoxDecoration(
          color: ColorSystem.lightBlue,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorSystem.Blue),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 70,
              child: ScrollDateTimePicker(
                itemExtent: 54,
                infiniteScroll: false,
                onChange: (datetime) {
                  viewModel.updateSelectedHours(datetime);
                },
                dateOption: DateTimePickerOption(
                  dateFormat: DateFormat('HH'),
                  minDate: DateTime(2024),
                  maxDate: DateTime(2030),
                  initialDate: viewModel.selectedTimeHours.value,
                ),
                centerWidget: DateTimePickerCenterWidget(
                  builder: (context, constraints, child) => const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                style: DateTimePickerStyle(
                  activeStyle: FontSystem.KR36B.copyWith(
                    color: ColorSystem.Blue,
                  ),
                  inactiveStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.transparent,
                  ),
                  disabledStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(
              ':',
              style: FontSystem.KR36B.copyWith(
                color: ColorSystem.Blue,
              ),
            ),
            SizedBox(
              width: 70,
              child: ScrollDateTimePicker(
                itemExtent: 54,
                infiniteScroll: false,
                onChange: (datetime) {
                  viewModel.updateSelectedMinutes(datetime);
                },
                dateOption: DateTimePickerOption(
                  dateFormat: DateFormat('mm'),
                  minDate: DateTime(2024),
                  maxDate: DateTime(2030),
                  initialDate: viewModel.selectedTimeMinutes.value,
                ),
                centerWidget: DateTimePickerCenterWidget(
                  builder: (context, constraints, child) => const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                style: DateTimePickerStyle(
                  activeStyle: FontSystem.KR36B.copyWith(
                    color: ColorSystem.Blue,
                  ),
                  inactiveStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.transparent,
                  ),
                  disabledStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
