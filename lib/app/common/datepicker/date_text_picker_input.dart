// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:new_ics/gen/assets.gen.dart';

class DateTextPickerInputReNewPassport<T> extends StatefulWidget {
  const DateTextPickerInputReNewPassport({
    Key? key,
    required this.controller,
    required this.dateValidator,
    required this.monthValidator,
    required this.yearValidator,
  }) : super(key: key);

  final T controller;
  final String? Function(String?)? dateValidator;
  final String? Function(String?)? monthValidator;
  final String? Function(String?)? yearValidator;

  @override
  State<DateTextPickerInputReNewPassport> createState() =>
      _DateTextPickerInputState();
}

class _DateTextPickerInputState
    extends State<DateTextPickerInputReNewPassport> {
  late FocusNode yearFocusNode;
  late FocusNode monthFocusNode;
  late FocusNode dayFocusNode;

  @override
  void initState() {
    super.initState();
    yearFocusNode = FocusNode();
    monthFocusNode = FocusNode();
    dayFocusNode = FocusNode();
  }

  @override
  void dispose() {
    yearFocusNode.dispose();
    monthFocusNode.dispose();
    dayFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Invalid day';
              }
              int? day = int.tryParse(value);
              if (day == null || day < 1 || day > 31) {
                return 'Invalid day';
              }
              return null; // Return null if validation succeeds
            },
            textAlign: TextAlign.center,
            maxLength: 2,
            controller: widget.controller.dayController,
            keyboardType: TextInputType.number,
            focusNode: dayFocusNode,
            onChanged: (value) {
              if (value.length == 2) {
                FocusScope.of(context).requestFocus(monthFocusNode);
              }
            },
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.blackLight,
              fontSize: AppSizes.font_14,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                bottom: AppSizes.mp_v_1 / 2,
                top: AppSizes.mp_v_1 / 2,
              ),
              hintText: "DD",
              counterText: '',
              hintStyle: AppTextStyles.bodyLargeBold.copyWith(
                color: AppColors.grayLighter,
                fontSize: AppSizes.font_14,
              ),
              suffixIconConstraints: BoxConstraints(
                maxWidth: AppSizes.icon_size_10,
                maxHeight: AppSizes.icon_size_10,
              ),
              prefixIconConstraints: BoxConstraints(
                maxWidth: AppSizes.icon_size_10,
                maxHeight: AppSizes.icon_size_10,
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.grayLight),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.grayLight),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.grayLight),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.black),
              ),
            ),
            cursorColor: AppColors.primary,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_2),
          child: SvgPicture.asset(
            Assets.icons.slashforward,
            color: AppColors.grayLight,
            height: AppSizes.icon_size_6,
          ),
        ),
        Expanded(
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Invalid month'.tr;
              }
              int? month = int.tryParse(value);
              if (month == null || month < 1 || month > 12) {
                return 'Invalid month'.tr;
              }
              return null; // Return null if validation succeeds
            },
            controller: widget.controller.monthController,
            maxLength: 2,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            focusNode: monthFocusNode,
            onChanged: (value) {
              if (value.length == 2) {
                FocusScope.of(context).requestFocus(yearFocusNode);
              }
            },
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.blackLight,
              fontSize: AppSizes.font_14,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                bottom: AppSizes.mp_v_1 / 2,
                top: AppSizes.mp_v_1 / 2,
              ),
              hintText: "MM",
              counterText: '',
              hintStyle: AppTextStyles.bodyLargeBold.copyWith(
                color: AppColors.grayLighter,
                fontSize: AppSizes.font_14,
              ),
              suffixIconConstraints: BoxConstraints(
                maxWidth: AppSizes.icon_size_10,
                maxHeight: AppSizes.icon_size_10,
              ),
              prefixIconConstraints: BoxConstraints(
                maxWidth: AppSizes.icon_size_10,
                maxHeight: AppSizes.icon_size_10,
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.grayLight),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.grayLight),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.grayLight),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.black),
              ),
            ),
            cursorColor: AppColors.primary,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.mp_w_2),
          child: SvgPicture.asset(
            Assets.icons.slashforward,
            color: AppColors.grayLight,
            height: AppSizes.icon_size_6,
          ),
        ),
        Expanded(
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'enter a year'.tr;
              }
              if (value.length != 4) {
                return 'Invalid year'.tr;
              }
              int? year = int.tryParse(value);
              int currentYear = int.parse(
                DateFormat('yyyy').format(DateTime.now()),
              ); // Get the current year
              if (year == null ||
                  year < 0 ||
                  year < 150 ||
                  year > currentYear) {
                return 'Invalid year'.tr;
              }

              return null; // Return null if validation succeeds
            },
            controller: widget.controller.yearController,
            maxLength: 4,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            focusNode: yearFocusNode,
            onChanged: (value) {
              if (value.length == 4) {
                int age = calculateAge();

                if (age > 150) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Age cannot be more than 150 years'.tr),
                    ),
                  );
                  return;
                }

                if (age > 18) {
                  widget.controller.showAdoption(false);
                } else {
                  widget.controller.showAdoption(true);
                }
              }
            },
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.blackLight,
              fontSize: AppSizes.font_14,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                bottom: AppSizes.mp_v_1 / 2,
                top: AppSizes.mp_v_1 / 2,
              ),
              hintText: "YYYY",
              counterText: '',
              hintStyle: AppTextStyles.bodyLargeBold.copyWith(
                color: AppColors.grayLighter,
                fontSize: AppSizes.font_14,
              ),
              suffixIconConstraints: BoxConstraints(
                maxWidth: AppSizes.icon_size_10,
                maxHeight: AppSizes.icon_size_10,
              ),
              prefixIconConstraints: BoxConstraints(
                maxWidth: AppSizes.icon_size_10,
                maxHeight: AppSizes.icon_size_10,
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.grayLight),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.grayLight),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.grayLight),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.black),
              ),
            ),
            cursorColor: AppColors.primary,
          ),
        ),
      ],
    );
  }

  int calculateAge() {
    DateTime currentDate = DateTime.now();
    int currentYear = currentDate.year;
    int currentMonth = currentDate.month;
    int currentDay = currentDate.day;

    int birthYear = int.tryParse(widget.controller.yearController.text) ?? 0;
    int birthMonth = int.tryParse(widget.controller.monthController.text) ?? 0;
    int birthDay = int.tryParse(widget.controller.dayController.text) ?? 0;

    int age = currentYear - birthYear;

    if (currentMonth < birthMonth ||
        (currentMonth == birthMonth && currentDay < birthDay)) {
      age--;
    }

    return age;
  }
}
