import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_ics/app/modules/my_order/controllers/my_order_controller.dart';
import 'package:new_ics/app/modules/my_order/models/order_model_all_appllication.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:new_ics/app/utils/constants.dart';



import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class BuildDocViewer extends StatefulWidget {
  final String pdfPath;
  final String reviewStatus;
  final String rejected_reason;
  final String applicationId;
  final CurrentCountry documentType;
  final MyOrderController controller;

  const BuildDocViewer(
      {required this.pdfPath,
      required this.reviewStatus,
      required this.rejected_reason,
      required this.controller,
      required this.applicationId,
      required this.documentType});

  @override
  _BuildDocState createState() => _BuildDocState();
}

class _BuildDocState extends State<BuildDocViewer> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          //  margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.all(Radius.circular(18))),
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.file_present,
                  color: Colors.lightBlue[900],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 4.h,
                      width: 18.w,
                      decoration: BoxDecoration(
                        color: getReviewStatusColor(
                            widget.reviewStatus.toString()),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(
                            () => widget.controller.isfechedorder.value
                                ? Text(
                                    widget.reviewStatus.toString(),
                                    style: AppTextStyles.bodySmallBold.copyWith(
                                        color: AppColors.whiteOff,
                                        fontSize: AppSizes.font_10),
                                  )
                                : SizedBox(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              widget.reviewStatus.toString().contains("REJECTED")
                  ? GestureDetector(
                      onTap: () {
                        _showreasonDialog(
                          context,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.quiz_sharp,
                              color: AppColors.primary,
                            ),
                            Text("Rejected reason".tr,
                                style: AppTextStyles.menuRegular.copyWith(
                                  color: AppColors.primary,
                                )),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
              GestureDetector(
                onTap: () {
                  _showAreYouSureDialog(context, widget.pdfPath);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.remove_red_eye,
                        color: AppColors.primary,
                      ),
                      Text("View".tr,
                          style: AppTextStyles.menuRegular.copyWith(
                            color: AppColors.primary,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      shrinkWrap: true,
      itemCount: 1,
      padding: const EdgeInsets.all(0),
      controller: ScrollController(keepScrollOffset: false),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 2.h,
        );
      },
    );
  }

  void _showAreYouSureDialog(
    BuildContext context,
    String pdfPath,
  ) {
   
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: AppColors.danger,
                ),
              ),
            ],
          ),
          actions: [
            Container(
              height: 50.h,
              child:
                  PDF(swipeHorizontal: true, enableSwipe: true).cachedFromUrl(
                Constants.fileViewer + pdfPath,
                placeholder: (progress) => Center(child: Text('$progress %')),
                errorWidget: (error) => Center(child: Text('PDF Not Found'.tr)),
              ),
            )
          ],
        );
      },
    );
  }

  void _showreasonDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: AppColors.danger,
                ),
              ),
            ],
          ),
          actions: [
            Container(
              height: 20.h,
              child: Center(
                child: Text(
                    widget.rejected_reason == "null"
                        ? ""
                        : widget.rejected_reason.toString(),
                    style: AppTextStyles.menuRegular.copyWith(
                      color: AppColors.primary,
                    )),
              ),
            )
          ],
        );
      },
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
}
