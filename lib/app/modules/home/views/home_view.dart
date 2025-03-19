// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:new_ics/app/common/appbar/customappbar.dart';
import 'package:new_ics/app/common/loading/custom_loading_widget.dart';
import 'package:new_ics/app/modules/home/controllers/home_controller.dart';
import 'package:new_ics/app/modules/home/views/widget/featured_news_item.dart';
import 'package:new_ics/app/modules/home/views/widget/news_carousel_slider.dart';
import 'package:new_ics/app/routes/app_pages.dart';
import 'package:new_ics/app/theme/app_assets.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController controller;
  @override
  void initState() {
    controller = Get.put(HomeController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Hello'.tr,
        title2: "welcome".tr,
        logo: AppAssets.splasehimage2,
        showActions: true,
        actionIcon: Icon(Icons.language, color: AppColors.primary),
        routeName: () {
          Get.toNamed(Routes.LANGUAGE);
        },
        showLeading: false,
      ),
      backgroundColor: AppColors.whiteOff.withOpacity(0.9),
      body: Obx(
        () =>
            !controller.hasgettype.value
                ? buildBody()
                : Center(child: CustomLoadingWidget()),
      ),
    );
  }

  __buildBanner() {
    controller.featuredNews =
        controller.images
            .map(
              (e) => FeaturedNewsItem(
                imageUrl: e,
                newsDescription:
                    'It was pointed out that foreign employment is developing a system',
                date: 'NOV 19',
                locationCity: 'Addis Ababa',
              ),
            )
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BannerCarouselSlider(
          items: controller.featuredNews,
          showIndicator: true,
        ),
      ],
    );
  }

  buildcardsPassport() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(1, (index) {
          return CardWidget(
            isOrgin: true,
            title: "New Passport".tr,
            subtitle:
                "First time applicants are requested to schedule for appointment. You receive confirmation via email or SMS. Print the last page which has your appointment date and time. Take the paper with you to your appointment consular."
                    .tr,
            svgPath: controller.svgPathsOrgin[0],
            iconColor: controller.color[0],
            onPressed: () {
              Get.toNamed(Routes.NEW_PASSPORT);
            },
          );
        }),
      ),
    );
  }

  // buildOriginId() {
  //   return Obx(
  //     () => SingleChildScrollView(
  //       child: Column(
  //         children: List.generate(
  //           controller.baseOriginIdRenewalType.length + 1,
  //           (index) {
  //             if (index == 0) {
  //               return CardWidget(
  //                 isOrgin: true,
  //                 title: "New Origin Id".tr,
  //                 subtitle: "Apply for a new Origin ID",
  //                 svgPath: controller.svgPathsOrgin[0],
  //                 iconColor: controller.color[0],
  //                 onPressed: () {
  //                   Get.toNamed(Routes.NEW_ORIGIN_ID);
  //                 },
  //               );
  //             } else {
  //               int adjustedIndex = index - 1;
  //               return CardWidget(
  //                 isOrgin: true,
  //                 svgPath: controller.svgPathsOrgin[adjustedIndex + 1],
  //                 title:
  //                     controller.baseOriginIdRenewalType[adjustedIndex].name
  //                         .toString(),
  //                 subtitle:
  //                     controller
  //                         .baseOriginIdRenewalType[adjustedIndex]
  //                         .description
  //                         .toString(),
  //                 iconColor: controller.color[adjustedIndex + 1],
  //                 onPressed: () {
  //                   Get.toNamed(
  //                     Routes.RENEW_ORIGIN_ID,
  //                     arguments: {
  //                       "RenewType":
  //                           controller.baseOriginIdRenewalType[adjustedIndex],
  //                     },
  //                   );
  //                 },
  //               );
  //             }
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  buildEVisa(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Visa'.tr,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  fontSize: AppSizes.font_16,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                'Services'.tr,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  fontSize: AppSizes.font_16,
                  color: AppColors.grayDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          SizedBox(
            width: 80.w,
            child: Text(
              'Your E-Visa is an essential document in international travel and for identification purposes.'
                  .tr,
              style: AppTextStyles.captionRegular.copyWith(
                fontSize: AppSizes.font_12,
                color: AppColors.grayDark,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  buildTravel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Travel Document'.tr,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  fontSize: AppSizes.font_16,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                'Services'.tr,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  fontSize: AppSizes.font_16,
                  color: AppColors.grayDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          SizedBox(
            width: 80.w,
            child: Text(
              'Your Travel Document is an essential document while living in Ethiopia for identification purposes.'
                  .tr,
              style: AppTextStyles.captionRegular.copyWith(
                fontSize: AppSizes.font_12,
                color: AppColors.grayDark,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  buildOrgin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Origin Id'.tr,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  fontSize: AppSizes.font_16,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                'Services'.tr,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  fontSize: AppSizes.font_16,
                  color: AppColors.grayDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          SizedBox(
            width: 80.w,
            child: Text(
              'Your origin ID is an essential document while living in Ethiopia for identification purposes.'
                  .tr,
              style: AppTextStyles.captionRegular.copyWith(
                fontSize: AppSizes.font_12,
                color: AppColors.grayDark,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // buildTravelCard() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: List.generate(controller.baseTravelType.length, (index) {
  //         return CardWidget(
  //           isOrgin: true,
  //           svgPath: controller.travel[index],
  //           title: controller.baseTravelType[index].name,
  //           subtitle: "Travel document".tr,
  //           iconColor: controller.colortravel[index],
  //           onPressed: () {
  //             Get.toNamed(
  //               Routes.ALL_TRAVEL_DOCUMENT,
  //               arguments: {
  //                 "base_travel_document_types":
  //                     controller.baseTravelType[index],
  //               },
  //             );
  //           },
  //         );
  //       }),
  //     ),
  //   );
  // }

  buildEVisaCard() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(4, (index) {
          return CardWidget(
            isOrgin: true,
            svgPath: controller.evisa[index],
            title: controller.Evisatitles[index],
            subtitle: "E-Visa service".tr,
            iconColor: controller.color[index],
            onPressed: () {
              if (index == 0) {
                Get.toNamed(Routes.EVISA);
              } else if (index == 1) {
                Get.toNamed(Routes.CHANGE_VISA);
              } else if (index == 2) {
                Get.toNamed(Routes.VISA_EXTANTION);
              } else if (index == 3) {
                Get.toNamed(Routes.VISA_CANCELLATION);
              }
            },
          );
        }),
      ),
    );
  }

  buildRE(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Resident Permit'.tr,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  fontSize: AppSizes.font_16,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                'Services'.tr,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  fontSize: AppSizes.font_16,
                  color: AppColors.grayDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          SizedBox(
            width: 80.w,
            child: Text(
              'Your Resident Permit is an essential document in international travel and for identification purposes.'
                  .tr,
              style: AppTextStyles.captionRegular.copyWith(
                fontSize: AppSizes.font_12,
                color: AppColors.grayDark,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // buildRECard() {
  //   return Obx(
  //     () => SingleChildScrollView(
  //       child: Column(
  //         children: List.generate(
  //           controller.baseResidencyRenewalType.length + 1,
  //           (index) {
  //             if (index == 0) {
  //               return CardWidget(
  //                 isOrgin: true,
  //                 title: "New Resident ID".tr,
  //                 subtitle: "Apply for a new Resident ID",
  //                 svgPath: controller.svgPathsOrgin[0],
  //                 iconColor: controller.color[0],
  //                 onPressed: () {
  //                   Get.toNamed(Routes.RESIDENCY);
  //                 },
  //               );
  //             } else {
  //               int adjustedIndex = index - 1;
  //               return CardWidget(
  //                 isOrgin: true,
  //                 svgPath: controller.svgPathsOrgin[adjustedIndex + 1],
  //                 title:
  //                     controller.baseResidencyRenewalType[adjustedIndex].name!,
  //                 subtitle:
  //                     controller
  //                         .baseResidencyRenewalType[adjustedIndex]
  //                         .description
  //                         .toString(),
  //                 iconColor: controller.color[adjustedIndex + 1],
  //                 onPressed: () {
  //                   Get.toNamed(
  //                     Routes.RENEW_RESIDENCE,
  //                     arguments: {
  //                       "RenewType":
  //                           controller.baseResidencyRenewalType[adjustedIndex],
  //                     },
  //                   );
  //                 },
  //               );
  //             }
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  buildSC(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Service Complaint'.tr,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  fontSize: AppSizes.font_16,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                'Services'.tr,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  fontSize: AppSizes.font_16,
                  color: AppColors.grayDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          SizedBox(
            width: 80.w,
            child: Text(
              'Your feedback is important for our service improvement. Please pick the service you have an issue with'
                  .tr,
              style: AppTextStyles.captionRegular.copyWith(
                fontSize: AppSizes.font_12,
                color: AppColors.grayDark,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  buildbuildSCCard() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(2, (index) {
          return CardWidget(
            isOrgin: true,
            svgPath: controller.sc[index],
            title: controller.SCtitles[index],
            subtitle: "Service Complaint".tr,
            iconColor: controller.color[index],
            onPressed: () {
              if (index == 0) {
                Get.toNamed(Routes.COMPLAIN_PAGE);
              } else if (index == 1) {
                Get.toNamed(Routes.FEEDBACK_PAGE);
              }
            },
          );
        }),
      ),
    );
  }

  buildBody() {
    return Column(
      children: [
        SizedBox(height: 1.h),
        __buildBanner(),
        Obx(
          () => TabBar(
            controller: controller.tabController.value,
            tabAlignment: TabAlignment.center,
            isScrollable: true,

            onTap: (value) {
              setState(() {});
            },

            indicatorColor: AppColors.primary,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: AppColors.primary, // Active state color
            unselectedLabelColor: AppColors.grayDefault, // Inactive state color
            labelStyle: AppTextStyles.bodyLargeBold.copyWith(
              fontSize: AppSizes.font_12,
              color: AppColors.primary,
            ),
            tabs: [
              Tab(
                text: 'Passport'.tr,
                icon: Icon(
                  Icons.perm_identity_outlined,
                  color: _getIconColor(
                    0,
                  ), // Use the method to get the icon color
                ),
              ),
              // Tab(
              //   text: 'Travel document'.tr,
              //   icon: Icon(
              //     Icons.airplane_ticket_outlined,
              //     color: _getIconColor(
              //       1,
              //     ), // Use the method to get the icon color
              //   ),
              // ),
              // Tab(
              //   text: 'Origin ID'.tr,
              //   icon: Icon(
              //     Icons.perm_identity_outlined,
              //     color: _getIconColor(
              //       2,
              //     ), // Use the method to get the icon color
              //   ),
              // ),
              // Tab(
              //   text: 'Visa'.tr,
              //   icon: Icon(
              //     Icons.document_scanner_outlined,
              //     color: _getIconColor(
              //       3,
              //     ), // Use the method to get the icon color
              //   ),
              // ),
              // Tab(
              //   text: 'Resident Permit'.tr,
              //   icon: Icon(
              //     Icons.home_outlined,
              //     color: _getIconColor(
              //       4,
              //     ), // Use the method to get the icon color
              //   ),
              // ),
              // Tab(
              //   text: 'Service Complaint'.tr,
              //   icon: Icon(
              //     Icons.report_problem_outlined,
              //     color: _getIconColor(
              //       5,
              //     ), // Use the method to get the icon color
              //   ),
              // ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController.value,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [buildPassport(context), buildcardsPassport()],
                  ),
                ),
              ),
              // SingleChildScrollView(
              //   child: Padding(
              //     padding: const EdgeInsets.all(12.0),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [buildTravel(context), buildTravelCard()],
              //     ),
              //   ),
              // ),
              // SingleChildScrollView(
              //   child: Padding(
              //     padding: const EdgeInsets.all(12.0),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [buildOrgin(context), buildOriginId()],
              //     ),
              //   ),
              // ),
              // SingleChildScrollView(
              //   child: Padding(
              //     padding: const EdgeInsets.all(12.0),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [buildEVisa(context), buildEVisaCard()],
              //     ),
              //   ),
              // ),
              // SingleChildScrollView(
              //   child: Padding(
              //     padding: const EdgeInsets.all(12.0),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [buildRE(context), buildRECard()],
              //     ),
              //   ),
              // ),
              // SingleChildScrollView(
              //   child: Padding(
              //     padding: const EdgeInsets.all(12.0),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [buildSC(context), buildbuildSCCard()],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getIconColor(int tabIndex) {
    return controller.tabController.value.index == tabIndex
        ? AppColors
            .primary // Active state color
        : AppColors.grayDefault; // Inactive state color
  }
}

buildPassport(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Passport'.tr,
              style: AppTextStyles.bodyLargeBold.copyWith(
                fontSize: AppSizes.font_16,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              'Services'.tr,
              style: AppTextStyles.bodyLargeBold.copyWith(
                fontSize: AppSizes.font_16,
                color: AppColors.grayDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        SizedBox(
          width: 80.w,
          child: Text(
            'Your Passport Document is an essential document while living in Ethiopia for identification purposes.'
                .tr,
            style: AppTextStyles.captionRegular.copyWith(
              fontSize: AppSizes.font_12,
              color: AppColors.grayDark,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

class CardWidget extends StatelessWidget {
  final String svgPath;
  final String title;
  final String subtitle;
  final Color? iconColor;
  final Function? onPressed;
  final bool? isOrgin;
  final bool? isRe;

  CardWidget({
    required this.svgPath,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    this.onPressed,
    this.isOrgin,
    this.isRe,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Card(
        margin: EdgeInsets.all(8),
        color: AppColors.whiteOff,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        svgPath,
                        color: iconColor,
                        height: 12.w,
                        width: 12.w,
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: 50.w,
                        child: Text(
                          title,
                          style: AppTextStyles.bodySmallBold.copyWith(
                            fontSize: AppSizes.font_14,
                            color: AppColors.primary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withOpacity(
                            0.2,
                          ), // Blue color for the circle
                        ),
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          color: AppColors.primary,
                          size: 12,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "View Details".tr,
                        style: AppTextStyles.bodyLargeRegular.copyWith(
                          fontSize: AppSizes.font_12,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                subtitle,
                style: AppTextStyles.captionRegular.copyWith(
                  fontSize: AppSizes.font_12,
                  color: AppColors.grayDark,
                ),
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<TextSpan> getTitleTextSpans(String title) {
    List<String> words = title.split(' ');

    // If the title contains only one word, return a single TextSpan
    if (words.length == 1) {
      return [TextSpan(text: words[0])];
    }

    // If the title contains two words, split the second word into a new line
    return [
      TextSpan(text: words[0]),
      TextSpan(text: '\n'),
      TextSpan(text: words[1]),
    ];
  }
}
