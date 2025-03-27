// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:new_ics/app/common/appbar/customappbar.dart';
import 'package:new_ics/app/common/loading/custom_loading_widget.dart';
import 'package:new_ics/app/common/timeline/timeline.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:new_ics/app/modules/my_order/models/order_model_all_appllication.dart';
import 'package:new_ics/app/modules/my_order/views/widgets/doc/doc_causole.dart';
import 'package:new_ics/app/theme/app_assets.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:new_ics/app/utils/constants.dart';
import 'package:new_ics/gen/assets.gen.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class DetailPassportWidget extends StatefulWidget {
  final IcsApplication icsApplication;

  DetailPassportWidget({required this.icsApplication});

  @override
  State<DetailPassportWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<DetailPassportWidget> {
  late MyOrderController controller;
  @override
  void initState() {
    controller = Get.find<MyOrderController>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Orders'.tr,
        title2: 'Status'.tr,
        showActions: true,
        showLeading: true,
        actionIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () =>
                controller.isfechedorder.value
                    ? Container(
                      height: 4.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        color: getReviewStatusColor(
                          widget.icsApplication.reviewStatus,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.icsApplication.reviewStatus,
                            style: AppTextStyles.bodySmallBold.copyWith(
                              color: AppColors.whiteOff,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    )
                    : SizedBox(),
          ),
        ),
      ),
      backgroundColor: AppColors.whiteOff,
      body: Obx(
        () =>
            controller.networkStatus.value == NetworkStatus.LOADING
                ? CustomLoadingWidget()
                : Column(
                  children: [
                    SizedBox(height: 1.h),
                    TabBar(
                      controller: controller.tabControllerPassport,
                      tabAlignment: TabAlignment.center,
                      isScrollable: true,
                      labelStyle: AppTextStyles.bodyLargeBold.copyWith(
                        fontSize: AppSizes.font_10,
                        color: AppColors.primary,
                      ),
                      tabs: [
                        Tab(text: 'Status'.tr, icon: Icon(Icons.check_circle)),
                        Tab(
                          text: 'Profile'.tr,
                          icon: SvgPicture.asset(
                            Assets.icons.profileDefault,
                            color: AppColors.primary,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Tab(
                          text: 'Documents'.tr,
                          icon: SvgPicture.asset(
                            Assets.icons.memo,
                            color: AppColors.primary,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabControllerPassport,
                        children: [buildStatus(), buildForm(), buildDocument()],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget buildStatus() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          MyTimeLineTiles(
            isFirst: true,
            isLast: false,
            isPast: true,
            eventchild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Passport Order Placed".tr,
                  style: AppTextStyles.menuBold.copyWith(
                    color: AppColors.whiteOff,
                  ),
                ),
                Text(
                  "Your Passport order is placed".tr,
                  style: AppTextStyles.menuRegular.copyWith(
                    color: AppColors.whiteOff,
                  ),
                ),
              ],
            ),
          ),
          MyTimeLineTiles(
            isFirst: false,
            isLast: false,
            isPast: true,
            eventchild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment Paid".tr,
                  style: AppTextStyles.menuBold.copyWith(
                    color: AppColors.whiteOff,
                  ),
                ),
                Text(
                  "You have successfully paid the order payment".tr,
                  style: AppTextStyles.menuRegular.copyWith(
                    color: AppColors.whiteOff,
                  ),
                ),
              ],
            ),
          ),
          MyTimeLineTiles(
            isFirst: false,
            isLast: false,
            isrejected:
                widget.icsApplication.reviewStatus.contains("REJECTED")
                    ? true
                    : false,
            isPast: true,
            eventchild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.icsApplication.reviewStatus,
                  style: AppTextStyles.menuBold.copyWith(
                    color: AppColors.whiteOff,
                  ),
                ),
                Text(
                  "",
                  style: AppTextStyles.menuRegular.copyWith(
                    color: AppColors.whiteOff,
                  ),
                ),
              ],
            ),
          ),
          MyTimeLineTiles(
            isFirst: false,
            isLast: true,
            isPast: false,
            eventchild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Delivery: ",
                      style: AppTextStyles.menuBold.copyWith(
                        color: AppColors.whiteOff,
                      ),
                    ),
                    Text(
                      " ${widget.icsApplication.deliveryStatus.toString()}",
                      style: AppTextStyles.menuBold.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                _buildAppointemnt(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointemnt() {
    bool isRenew = widget.icsApplication.renewPassportApplications.isNotEmpty;
    String dateText =
        isRenew ? "Delivery date :- ".tr : "Appointment date :- ".tr;
    String dateValue =
        isRenew
            ? getDeliveryDate(widget.icsApplication)
            : getAppointmentdate(widget.icsApplication);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          dateText,
          style: AppTextStyles.bodyLargeBold.copyWith(
            color: AppColors.whiteOff,
            fontSize: AppSizes.font_12,
          ),
        ),
        Text(
          dateValue,
          style: AppTextStyles.bodyLargeBold.copyWith(
            color: AppColors.black,
            fontSize: AppSizes.font_12,
          ),
        ),
      ],
    );
  }

  String getDeliveryDate(IcsApplication icsApplication) {
    if (icsApplication.renewPassportApplications.isNotEmpty) {
      String formattedDateTime = DateFormat(
        "EEE/d/yyyy",
      ).format(icsApplication.renewPassportApplications.first.deliveryDate!);
      return formattedDateTime;
    }
    return "";
  }

  String getAppointmentdate(IcsApplication icsApplication) {
    if (icsApplication.applicationAppointments.isNotEmpty) {
      String formattedDateTime = DateFormat(
        "EEE/d/yyyy",
      ).format(icsApplication.applicationAppointments.first.date);
      return formattedDateTime;
    }
    return "";
  }

  buildForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppAssets.splasehimage2,
              height: 5.h,
              width: 55.w,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80.0,
                  height: 80.0,
                  child: QrImageView(
                    data: widget.icsApplication.id,
                    version: QrVersions.auto,
                    size: 400.0,
                  ),
                ),
                SizedBox(width: 5.w),
                Container(
                  width: 80.0,
                  height: 80.0,
                  child:
                      widget.icsApplication.photo != null
                          ? CachedNetworkImage(
                            imageUrl:
                                Constants.fileViewer +
                                widget.icsApplication.photo!,
                            fit: BoxFit.contain,
                            height: 28.h,
                            width: double.infinity,
                            placeholder:
                                (context, str) => Container(
                                  color: AppColors.whiteOff,
                                  height: 28.h,
                                ),
                            errorWidget:
                                (context, url, error) => Container(
                                  color: AppColors.whiteOff,
                                  height: 28.h,
                                ),
                          )
                          : Container(
                            color: AppColors.danger,
                            height: 28.h,
                            alignment: Alignment.center,
                            child: Text(
                              'No image found'.tr,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.menuBold.copyWith(
                                color: AppColors.whiteOff,
                              ),
                            ),
                          ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                headLines(number: '01', title: 'Personal information'.tr),
                SizedBox(height: 2.h),
                textText(
                  subtitle: 'First name'.tr,
                  title: '${widget.icsApplication.firstName.toString()}',
                ),
                textText(
                  subtitle: 'Father Name'.tr,
                  title: '${widget.icsApplication.fatherName.toString()}',
                ),
                textText(
                  subtitle: 'Grand Father Name'.tr,
                  title: '${widget.icsApplication.grandFatherName.toString()}',
                ),
                textText(
                  subtitle: 'የመጀመሪያ ስም',
                  title: '${widget.icsApplication.firstNameJson.am.toString()}',
                ),
                textText(
                  subtitle: "የአባት ስም".tr,
                  title:
                      '${widget.icsApplication.fatherNameJson.am.toString()}',
                ),
                textText(
                  subtitle: "የአያት ስም".tr,
                  title: '${widget.icsApplication.grandFatherNameJson.am}',
                ),
                textText(
                  subtitle: "Gender".tr,
                  title: '${widget.icsApplication.gender.toString()}',
                ),
                textText(
                  subtitle: "Birth place".tr,
                  title: '${widget.icsApplication.birthPlace.toString()}',
                ),
                textText(
                  subtitle: "Birth Country".tr,
                  title:
                      '${widget.icsApplication.birthCountry.name.toString()}',
                ),
                textText(
                  subtitle: "Date of birth(GC)".tr,
                  title: removeHourFromDateTimeString(
                    widget.icsApplication.dateOfBirth.toString(),
                  ),
                ),
                textText(
                  subtitle: "Nationality".tr,
                  title: '${widget.icsApplication.nationality.name.toString()}',
                ),
                textText(
                  subtitle: "Adoption".tr,
                  title: '${widget.icsApplication.isAdopted.toString()}',
                ),
                textText(
                  subtitle: "Occupation".tr,
                  title:
                      '${widget.icsApplication.occupation?.name.toString() ?? ""}',
                ),
                textText(
                  subtitle: "Hair color".tr,
                  title: '${widget.icsApplication.hairColour}',
                ),
                textText(
                  subtitle: "eye color".tr,
                  title: '${widget.icsApplication.eyeColour}',
                ),
                textText(
                  subtitle: "Skin color".tr,
                  title: '${widget.icsApplication.skinColour}',
                ),
                textText(
                  subtitle: "Marital Status".tr,
                  title: '${widget.icsApplication.maritalStatus}',
                ),
                textText(
                  subtitle: "height".tr,
                  title: '${widget.icsApplication.height}',
                ),
                SizedBox(height: 2.h),
                headLines(number: '02', title: 'Address'.tr),
                textText(
                  subtitle: "Current Country",
                  title:
                      '${widget.icsApplication.currentCountry.name.toString()}',
                ),
                textText(
                  subtitle: "Address Detail",
                  title: '${widget.icsApplication.abroadAddress.toString()}',
                ),
                textText(
                  subtitle: "Phone Number",
                  title: '${widget.icsApplication.phoneNumber.toString()}',
                ),
                SizedBox(height: 2.h),
                headLines(number: '03', title: 'Passport Information'.tr),
                widget.icsApplication.renewPassportApplications.isNotEmpty
                    ? textText(
                      subtitle: "Current Passport number".tr,
                      title: getnumber(widget.icsApplication),
                    )
                    : SizedBox(),
                widget.icsApplication.newPassportApplications.isNotEmpty
                    ? textText(
                      subtitle: "Passport Type".tr,
                      title:
                          '${widget.icsApplication.newPassportApplications.first.passportType!.name.toString()}',
                    )
                    : textText(
                      subtitle: "ReNew Passport Type".tr,
                      title:
                          '${widget.icsApplication.renewPassportApplications.first.passportRenewalType.name.toString()}',
                    ),
                SizedBox(height: 2.h),
                textText(
                  subtitle: "Urgency Type".tr,
                  title:
                      '${widget.icsApplication.serviceUrgencyLevel!.name.toString()}',
                ),
                SizedBox(height: 2.h),
                widget.icsApplication.newPassportApplications.isNotEmpty
                    ? textText(
                      subtitle: "Passport Page Size".tr,
                      title:
                          '${widget.icsApplication.newPassportApplications.first.passportPageSize!.name.toString()}',
                    )
                    : SizedBox(),
                Container(height: 100),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getReviewStatusColor(String reviewStatus) {
    switch (reviewStatus) {
      case "REJECTED":
      case "NOT SUBMITTED":
        return AppColors.danger;
      case "VERIFIED":
      case "AUTHORIZED":
        return AppColors.success;
      default:
        return AppColors.warning;
    }
  }

  Widget headLines({required String number, required String title}) {
    return Column(
      children: [
        Row(
          children: [
            Text(number, style: AppTextStyles.titleBold),
            const SizedBox(width: 10),
            Container(height: 25, width: 3, color: AppColors.primary),
            const SizedBox(width: 10),
            Text(
              title,
              style: AppTextStyles.titleBold.copyWith(color: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget textText({required String subtitle, required String title}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Text(
                    '$subtitle :  ',
                    style: AppTextStyles.bodyLargeBold.copyWith(fontSize: 18),
                  ),
                  Flexible(
                    child: Text(title, style: AppTextStyles.bodyLargeRegular),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: AppColors.primaryDark),
        ],
      ),
    );
  }

  String removeHourFromDateTimeString(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDateTime = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDateTime;
  }

  buildDocument() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(height: 1.0),
      itemCount: controller.groupedAppliaction.length,
      itemBuilder: (context, index) {
        return ItemDoc(
          title: controller.groupedAppliaction[index].documentType.name,
          documentType: controller.groupedAppliaction[index].documentType,
          controller: controller,
          listOfDoc: controller.groupedAppliaction[index].document,
          applicationId: widget.icsApplication.id,
        );
      },
    );
  }

  getQrData(IcsApplication icsNewApplicationModel) {
    {
      if (icsNewApplicationModel.renewPassportApplications.isNotEmpty) {
        return icsNewApplicationModel
            .renewPassportApplications
            .first
            .applicationNo
            .toString();
      } else if (icsNewApplicationModel.newPassportApplications.isNotEmpty) {
        return icsNewApplicationModel
            .newPassportApplications
            .first
            .applicationNo
            .toString();
      } else {
        return "";
      }
    }
  }

  getnumber(IcsApplication icsApplication) {
    if (icsApplication.renewPassportApplications.isNotEmpty) {
      return icsApplication.renewPassportApplications.first.passportNumber
          .toString();
    } else if (icsApplication.newPassportApplications.isNotEmpty) {
      return "";
    } else {
      return "";
    }
  }
}
