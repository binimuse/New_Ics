import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:interval_time_picker/interval_time_picker.dart';
import 'package:new_ics/app/common/appbar/customappbar.dart';
import 'package:new_ics/app/common/button/custom_normal_button.dart';
import 'package:new_ics/app/common/custom_callender.dart';
import 'package:new_ics/app/common/loading/custom_loading_widget.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:new_ics/app/modules/new_passport/views/widget/form/new_passport_form.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentStep extends StatelessWidget {
  final NewPassportController controller = Get.find<NewPassportController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 2.h),
                Expanded(child: _buildCalendar(context)),
                SizedBox(height: 2.h),
                _buildNextButton(),
              ],
            ),
            Obx(
              () =>
                  controller.networkStatus.value == NetworkStatus.LOADING
                      ? Center(child: CustomLoadingWidget())
                      : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: 'Schedule'.tr,
      title2: "Appointment".tr,
      showLeading: true,
      showActions: true,
      actionIcon: Icon(Icons.close),
      routeName: () {
        Get.offAllNamed(Routes.MAIN_PAGE);
      },
    );
  }

  Widget _buildCalendar(BuildContext context) {
    final DateTime today = DateTime.now();
    return CustomCalendar(
      blackoutDates: controller.occupiedDates,
      minDate: today,
      maxDate: DateTime(today.year, today.month + 3, today.day),
      onTap: (CalendarTapDetails details) => _onDateTapped(context, details),
    );
  }

  void _onDateTapped(BuildContext context, CalendarTapDetails details) {
    controller.selectedDate.value = details.date!;
    print(controller.selectedDate);

    // Show the time picker with one-hour intervals
    showIntervalTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      interval: 60,
    ).then((pickedTime) {
      if (pickedTime != null) {
        _setSelectedDateTime(pickedTime);
      }
    });
  }

  void _setSelectedDateTime(TimeOfDay pickedTime) {
    DateTime selectedDateTime = DateTime(
      controller.selectedDate.value!.year,
      controller.selectedDate.value!.month,
      controller.selectedDate.value!.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    // Update your controller or state with the selectedDateTime
    controller.selectedDateTime.value = selectedDateTime;
  }

  Widget _buildNextButton() {
    return Obx(() {
      final isButtonEnabled =
          controller.selectedDate.value != null &&
          controller.selectedDateTime.value != null;
      return CustomNormalButton(
        text: 'Next'.tr,
        textStyle: AppTextStyles.bodyLargeBold.copyWith(
          color: AppColors.whiteOff,
        ),
        textcolor: AppColors.whiteOff,
        buttoncolor: isButtonEnabled ? AppColors.primary : AppColors.grayLight,
        borderRadius: AppSizes.radius_8,
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.mp_v_2,
          horizontal: AppSizes.mp_w_6,
        ),
        onPressed: () {
          if (isButtonEnabled) {
            Get.to(() => NewPassportForm());
          }
        }, // Provide null when the button is disabled
      );
    });
  }
}
