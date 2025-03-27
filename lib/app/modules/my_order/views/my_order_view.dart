import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:new_ics/app/common/appbar/customappbar.dart';
import 'package:new_ics/app/common/loading/custom_loading_widget.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/modules/my_order/views/widgets/passport/passport_widget.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:new_ics/gen/assets.gen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/my_order_controller.dart';

class MyOrderView extends StatefulWidget {
  const MyOrderView({Key? key}) : super(key: key);

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
  late MyOrderController controller;

  @override
  void initState() {
    controller = Get.put(MyOrderController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My'.tr,
        title2: 'Orders'.tr,
        showActions: true,
        actionIcon: Icon(Icons.refresh, color: AppColors.primary),
        routeName: () async {
          // controller.getVisaApplication();
          // controller.getExitVisaApplication();
          // controller.getOrginOrder();
          // controller.getComplaint();
          // controller.getResidencyApplication();
        },
        showLeading: false,
      ),
      backgroundColor: AppColors.whiteOff,
      body: Obx(
        () =>
            controller.networkStatus.value != NetworkStatus.LOADING
                ? buildBodyContent(context)
                : Center(child: CustomLoadingWidget()),
      ),
    );
  }

  buildBodyContent(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: controller.tabController,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          labelStyle: AppTextStyles.bodyLargeBold.copyWith(
            fontSize: AppSizes.font_10,
            color: AppColors.primary,
          ),
          tabs: [
            Tab(
              text: 'Passport'.tr,
              icon: SvgPicture.asset(
                Assets.icons.passport,
                color: AppColors.primary,
                fit: BoxFit.contain,
              ),
            ),
            Tab(
              text: 'Travel Documents'.tr,
              icon: SvgPicture.asset(
                Assets.icons.passport,
                color: AppColors.primary,
                fit: BoxFit.contain,
              ),
            ),
            Tab(
              text: 'Origin ID'.tr,
              icon: SvgPicture.asset(
                Assets.icons.profileDefault,
                color: AppColors.primary,
                fit: BoxFit.contain,
              ),
            ),
            Tab(
              text: 'Visa'.tr,
              icon: SvgPicture.asset(
                Assets.icons.paper,
                color: AppColors.primary,
                fit: BoxFit.contain,
              ),
            ),
            Tab(
              text: 'Resident Permit'.tr,
              icon: SvgPicture.asset(
                Assets.icons.memo,
                color: AppColors.primary,
                fit: BoxFit.contain,
              ),
            ),
            Tab(
              text: 'Service Complaint'.tr,
              icon: SvgPicture.asset(
                Assets.icons.question,
                color: AppColors.primary,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              buildPassportTab(),
              // buildTravelDocumentsTab(),
              // buildOriginIDTab(),
              // buildVisaTab(),
              // buildResidentPermitTab(),
              // buildServiceComplaintTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPassportTab() {
    return Container(
      height: 100.h,
      child:
          controller.allApplicationModel.isEmpty
              ? Center(child: Text('No Passport Order found'.tr))
              : ListView.builder(
                itemCount: controller.allApplicationModel.length,
                itemBuilder: (context, index) {
                  var element = controller.allApplicationModel[index];
                  if (element.applicationType.contains(
                        "NEW_PASSPORT_APPLICATION",
                      ) ||
                      element.applicationType.contains(
                        "RENEW_PASSPORT_APPLICATION",
                      )) {
                    return PassportWidget(
                      icsApplication: controller.allApplicationModel[index],
                      controller: controller,
                    );
                  }

                  return SizedBox();
                },
              ),
    );
  }

  // Widget buildTravelDocumentsTab() {
  //   return Container(
  //     height: 100.h,
  //     child:
  //         controller.allApplicationModel.isEmpty
  //             ? Center(child: Text('No Travel Documents Order found'.tr))
  //             : ListView.builder(
  //               itemCount: controller.allApplicationModel.length,
  //               itemBuilder: (context, index) {
  //                 var element = controller.allApplicationModel[index];
  //                 if (element.applicationType.contains(
  //                   "NEW_TRAVEL_DOCUMENT_APPLICATION",
  //                 )) {
  //                   return TravelWidget(
  //                     icsApplication: controller.allApplicationModel[index],
  //                     controller: controller,
  //                   );
  //                 }

  //                 return SizedBox();
  //               },
  //             ),
  //   );
  // }

  // Widget buildOriginIDTab() {
  //   return Container(
  //     height: 100.h,
  //     child:
  //         controller.allApplicationModel.isEmpty
  //             ? Center(child: Text('No Origin ID Order found'.tr))
  //             : ListView.builder(
  //               itemCount: controller.allApplicationModel.length,
  //               itemBuilder: (context, index) {
  //                 var element = controller.allApplicationModel[index];
  //                 if (element.applicationType.contains(
  //                       "NEW_ORIGIN_ID_APPLICATION",
  //                     ) ||
  //                     element.applicationType.contains(
  //                       "RENEW_ORIGIN_ID_APPLICATION",
  //                     )) {
  //                   return OrginIdWidget(
  //                     icsApplication: controller.allApplicationModel[index],
  //                     controller: controller,
  //                   );
  //                 }
  //                 return SizedBox();
  //               },
  //             ),
  //   );
  // }

  // Widget buildVisaTab() {
  //   return Column(
  //     children: [
  //       TabBar(
  //         controller: controller.nestedTabController,
  //         labelStyle: AppTextStyles.bodyLargeBold.copyWith(
  //           fontSize: AppSizes.font_10,
  //           color: AppColors.primary,
  //         ),
  //         tabs: [Tab(text: 'Visa'.tr), Tab(text: 'Exit Visa'.tr)],
  //       ),
  //       Expanded(
  //         child: TabBarView(
  //           controller: controller.nestedTabController,
  //           children: [buildVisaContent(), buildExitVisaContent()],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget buildVisaContent() {
  //   return Container(
  //     height: 100.h,
  //     child:
  //         controller.allVisaApplicationModel.isEmpty
  //             ? Center(child: Text('No Visa Order found'.tr))
  //             : ListView.builder(
  //               itemCount: controller.allVisaApplicationModel.length,
  //               itemBuilder: (context, index) {
  //                 return VisaWidget(
  //                   icsApplication: controller.allVisaApplicationModel[index],
  //                   controller: controller,
  //                 );
  //               },
  //             ),
  //   );
  // }

  // Widget buildExitVisaContent() {
  //   return Container(
  //     height: 100.h,
  //     child:
  //         controller.icsExitVisaApplication.isEmpty
  //             ? Center(child: Text('No Exit Visa Order found'.tr))
  //             : ListView.builder(
  //               itemCount: controller.icsExitVisaApplication.length,
  //               itemBuilder: (context, index) {
  //                 return ExitVisaWidget(
  //                   icsApplication: controller.icsExitVisaApplication[index],
  //                   controller: controller,
  //                 );
  //               },
  //             ),
  //   );
  // }

  // Widget buildResidentPermitTab() {
  //   return Container(
  //     height: 100.h,
  //     child:
  //         controller.residencyModel.isEmpty
  //             ? Center(child: Text('No Resident Permit Order found'.tr))
  //             : ListView.builder(
  //               itemCount: controller.residencyModel.length,
  //               itemBuilder: (context, index) {
  //                 return ResidencyWidget(
  //                   icsApplication: controller.residencyModel[index],
  //                   controller: controller,
  //                 );
  //               },
  //             ),
  //   );
  // }

  // Widget buildServiceComplaintTab() {
  //   return Container(
  //     height: 100.h,
  //     child:
  //         controller.icsServiceComplaintModel.isEmpty
  //             ? Center(child: Text('No Service Complaint found'.tr))
  //             : ListView.builder(
  //               itemCount: controller.icsServiceComplaintModel.length,
  //               itemBuilder: (context, index) {
  //                 return ComplaintWidget(
  //                   icsComplain: controller.icsServiceComplaintModel[index],
  //                   controller: controller,
  //                 );
  //               },
  //             ),
  //   );
  // }
}
