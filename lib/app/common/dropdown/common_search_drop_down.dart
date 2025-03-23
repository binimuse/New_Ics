import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:new_ics/app/common/forms/reusableDropdown.dart';
import 'package:new_ics/app/common/model/basemodel.dart';
import 'package:new_ics/app/data/models/passport/base_country.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';

class CommonSearchDropDown extends StatelessWidget {
  const CommonSearchDropDown({
    Key? key,
    required this.onChanged,
    required this.currentValue,
    required this.options,
    required this.hint,
    this.suffixIcon,
    this.prefix,
    this.validator,
    this.title = '',
    this.isEnabled = true,
    this.name,
  }) : super(key: key);

  final String hint;
  final Widget? suffixIcon;
  final Widget? prefix;
  final BaseCountry? currentValue;
  final List<BaseCountry> options;
  final ValueChanged<BaseCountry?>? onChanged;
  final bool isEnabled;
  final String title;
  final String? Function(BaseCountry?)? validator;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<BaseCountry>(
      items: options,
      validator: validator,
      onChanged: onChanged,
      selectedItem: currentValue,
      itemAsString: (BaseCountry item) => item.name,
      asyncItems: (String filter) async {
        final results =
            options.where((item) {
              final itemName = item.name;
              return itemName.toLowerCase().contains(filter.toLowerCase());
            }).toList();
        return results;
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: AppTextStyles.bodyLargeBold.copyWith(
          color: AppColors.blackLight,
          fontSize: AppSizes.font_14,
        ),
        dropdownSearchDecoration: ReusableInputDecoration.getDecoration(hint),
      ),
      popupProps: PopupProps.bottomSheet(
        showSearchBox: true,
        searchDelay: const Duration(milliseconds: 400),
        itemBuilder:
            (context, item, isSelected) => Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.blackLight.withOpacity(0.1)),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: AppSizes.mp_v_2,
                horizontal: AppSizes.mp_w_2,
              ),
              child: Text(
                item.name,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  color: AppColors.black,
                  fontSize: AppSizes.font_14,
                ),
              ),
            ),
        containerBuilder:
            (context, widget) => Container(
              decoration: BoxDecoration(
                color: AppColors.whiteOff.withOpacity(0.8),
                boxShadow: [BoxShadow()],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: widget,
            ),
        searchFieldProps: TextFieldProps(
          padding: EdgeInsets.symmetric(
            vertical: AppSizes.mp_v_2,
            horizontal: AppSizes.mp_v_2,
          ),
          decoration: InputDecoration(
            fillColor: AppColors.whiteOff.withOpacity(
              0.8,
            ), // Set the search box color to black
            filled: true, // Ensure the fill color is applied
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.mp_w_4,
              vertical: AppSizes.mp_v_1 * 0.85,
            ),
            prefixIcon: prefix,
            counterText: '',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.whiteOff.withOpacity(0.8),
                width: 1.1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.whiteOff.withOpacity(0.8),
                width: 1.1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.whiteOff.withOpacity(0.8),
                width: 1.1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.whiteOff.withOpacity(0.8),
                width: 1.1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.1),
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: '',
            hintStyle: AppTextStyles.bodySmallBold.copyWith(
              color: AppColors.whiteOff.withOpacity(0.8),
              fontSize: AppSizes.font_14 * 0.85,
            ),
            errorStyle: AppTextStyles.bodySmallBold.copyWith(color: Colors.red),
            suffixIcon: suffixIcon,
          ),
        ),
        bottomSheetProps: BottomSheetProps(
          elevation: 16,
          backgroundColor: AppColors.warning,
        ),
      ),
    );
  }
}
