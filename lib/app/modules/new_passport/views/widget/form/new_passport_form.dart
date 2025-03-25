import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'package:im_stepper/stepper.dart';
import 'package:new_ics/app/common/app_toasts.dart';
import 'package:new_ics/app/common/appbar/customappbar.dart';
import 'package:new_ics/app/common/button/custom_normal_button.dart';
import 'package:new_ics/app/common/loading/custom_loading_widget.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/modules/new_passport/controllers/new_passport_controller.dart';
import 'package:new_ics/app/modules/new_passport/views/widget/form/confirmation_Page.dart';
import 'package:new_ics/app/modules/new_passport/views/widget/form/steps/step_five.dart';
import 'package:new_ics/app/modules/new_passport/views/widget/form/steps/step_four.dart';
import 'package:new_ics/app/modules/new_passport/views/widget/form/steps/step_one.dart';
import 'package:new_ics/app/modules/new_passport/views/widget/form/steps/step_six.dart';
import 'package:new_ics/app/modules/new_passport/views/widget/form/steps/step_three.dart';
import 'package:new_ics/app/modules/new_passport/views/widget/form/steps/step_two.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:image_picker/image_picker.dart';

class NewPassportForm extends StatefulWidget {
  const NewPassportForm();

  @override
  _StepperWithFormExampleState createState() => _StepperWithFormExampleState();
}

class _StepperWithFormExampleState extends State<NewPassportForm> {
  final NewPassportController controller = Get.find<NewPassportController>();
  final ScrollController _scrollController = ScrollController();
  final picker = ImagePicker();
  final int maxSizeInBytes = 50 * 1024 * 1024; // 50 MB

  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        stoppop: false,
        title: "New Passport Form".tr,
        // widget.baseTravelType == null
        //     ? 'New'.tr
        //     : widget.baseTravelType!.name.toString(),
        title2: "",
        showLeading: true,
        showActions: true,
        actionIcon: Icon(Icons.close),
        routeName: () {
          Get.offAllNamed(Routes.MAIN_PAGE);
        },
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [SizedBox(height: 1.h), buildForm(context)],
            ),
          ),
          Obx(
            () =>
                controller.networkStatus.value == NetworkStatus.LOADING
                    ? Center(child: CustomLoadingWidget())
                    : SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    return Obx(
      () => Container(
        color: AppColors.grayLighter.withOpacity(0.2),
        height: 87.h,
        child: Column(
          children: [
            buildStepper(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: FormBuilder(
                  key: controller.newPassportformKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  skipDisabled: true,
                  canPop: true,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: buildStepContent(),
                  ),
                ),
              ),
            ),
            buildNavigationButtons(context),
          ],
        ),
      ),
    );
  }

  Widget buildStepper() {
    return IconStepper(
      activeStep: controller.currentStep.value,
      lineColor: AppColors.secondary,
      stepColor: AppColors.grayDefault,
      activeStepColor: AppColors.primary,
      icons: [
        Icon(Icons.person, color: AppColors.whiteOff),
        Icon(Icons.person, color: AppColors.whiteOff),
        Icon(Icons.family_restroom, color: AppColors.whiteOff),
        Icon(Icons.edit_document, color: AppColors.whiteOff),
      ],
      onStepReached: (index) {
        controller.currentStep.value = index;
      },
      enableNextPreviousButtons: false,
      enableStepTapping: false,
    );
  }

  Widget buildStepContent() {
    return Column(
      children: [
        if (controller.currentStep.value == 0) Step1(controller: controller),
        if (controller.currentStep.value == 1) Step2(controller: controller),
        if (controller.currentStep.value == 2) Step3(controller: controller),
        if (controller.currentStep.value == 3) Step4(controller: controller),
        if (controller.currentStep.value == 4) Step5(controller: controller),
        if (controller.currentStep.value == 5) Step6(),
      ],
    );
  }

  Widget buildNavigationButtons(BuildContext context) {
    return Container(
      color: AppColors.whiteOff,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (controller.currentStep.value > 0) buildBackButton(),
          buildNextOrSubmitButton(context),
        ],
      ),
    );
  }

  Widget buildBackButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomNormalButton(
        text: 'Back'.tr,
        textStyle: AppTextStyles.bodyLargeBold.copyWith(
          color: AppColors.whiteOff,
        ),
        textcolor: AppColors.whiteOff,
        buttoncolor: AppColors.grayLight,
        borderRadius: AppSizes.radius_16,
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.mp_v_1,
          horizontal: AppSizes.mp_w_6,
        ),
        onPressed: () {
          if (controller.currentStep.value > 0) {
            controller.currentStep.value--;
          }
        },
      ),
    );
  }

  Widget buildNextOrSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomNormalButton(
        text: controller.currentStep.value == 4 ? 'Submit'.tr : 'Next'.tr,
        textStyle: AppTextStyles.bodyLargeBold.copyWith(
          color: AppColors.whiteOff,
        ),
        textcolor: AppColors.whiteOff,
        buttoncolor: AppColors.primary,
        borderRadius: AppSizes.radius_16,
        padding: EdgeInsets.symmetric(
          vertical: AppSizes.mp_v_1,
          horizontal: AppSizes.mp_w_6,
        ),
        onPressed: () async {
          if (controller.newPassportformKey.currentState!.saveAndValidate()) {
            await handleStepValidation(context);
          } else {
            _scrollToBottom();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Please fix the errors in red before proceeding.'.tr,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> handleStepValidation(BuildContext context) async {
    if (controller.currentStep.value == 0) {
      int age = calculateAge(
        int.parse(controller.yearController.text),
        int.parse(controller.monthController.text),
        int.parse(controller.dayController.text),
      );

      if (age > 150) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Age cannot be more than 150 years'.tr)),
        );
        return;
      } else {
        controller.currentStep.value++;
      }
    } else if (controller.currentStep.value == 1) {
      if (controller.selectedImages.isNotEmpty) {
        controller.currentStep.value++;
      } else {
        _scrollToBottom();
        AppToasts.showError("Please upload a photo.".tr);
        return; // Add return here to prevent step increment
      }
    } else if (controller.currentStep.value == 2) {
      if (controller.birthplace.text.isEmpty) {
        _scrollToBottom();
        AppToasts.showError("Birth place is required.".tr);
        return; // Add return here to prevent step increment
      }
      controller.currentStep.value++;
    } else if (controller.currentStep.value == 4) {
      checkdoc();
    } else {
      controller.currentStep.value++;
    }
  }

  void checkdoc() async {
    if (controller.documents.isEmpty) {
      AppToasts.showError("Document are empty".tr);
      return;
    } else {
      for (var document in controller.documents) {
        if (document.files.isEmpty) {
          final documentType = controller.basedocumentType.firstWhere(
            (type) => type.id == document.documentTypeId,
          );
          AppToasts.showError("${documentType.name} must not be empty".tr);

          return;
        }
      }
      controller.newPassportformKey.currentState!.saveAndValidate()
          ? _showSummeryDiloag(context)
          : SizedBox();
    }
  }

  // void finalStep(BuildContext context) {
  //   if (controller.selectedDate != null &&
  //       controller.selectedDateTime != null) {
  //     if (widget.baseTravelType != null) {
  //       controller.sendTravelDoc(widget.baseTravelType!);
  //     } else {
  //       controller.sends();
  //     }
  //   } else {
  //     AppToasts.showError("Please select both a date and a time".tr);
  //   }
  // }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  _showSummeryDiloag(BuildContext context) {
    Get.to(
      ConfirmationPagePassport(
        context: context,
        controller: controller,
        onTap: () {
          //Navigator.pop(context);
          controller.sendPassportData();
        },
        isFromFirstStep: false,
      ),
    );
  }

  int calculateAge(int year, int month, int day) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - year;
    if (currentDate.month < month ||
        (currentDate.month == month && currentDate.day < day)) {
      age--;
    }
    return age;
  }
}
