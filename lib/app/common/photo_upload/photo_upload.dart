// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:new_ics/app/common/dialogs/upload_dilaog.dart';
import 'package:new_ics/app/common/loading/custom_loading_widget.dart';
import 'package:new_ics/app/data/enums.dart';
import 'package:new_ics/app/theme/app_assets.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:new_ics/app/theme/app_sizes.dart';
import 'package:new_ics/app/theme/app_text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'dart:io';

class PhotoUpload extends StatelessWidget {
  PhotoUpload({Key? key, required this.selectedImages, required this.photoPath})
    : super(key: key);

  final RxList<File> selectedImages;
  final RxList<String> photoPath;

  Rx<NetworkStatus> networkStatus = Rx(NetworkStatus.IDLE);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [getImageFromGallery(context)],
      ),
    );
  }

  Widget getImageFromGallery(BuildContext context) {
    return InkWell(
      onTap: () {
        showUploadDialog(context);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.image, color: AppColors.primary),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 65.w,
                    child: Text(
                      'Recent Passport Size Photo'.tr,
                      style: AppTextStyles.bodySmallBold.copyWith(
                        color: AppColors.grayDark,
                        fontSize: AppSizes.font_12 * 1.2,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
              Obx(
                () =>
                    networkStatus.value == NetworkStatus.LOADING
                        ? CustomLoadingWidget()
                        : getImage(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImage(BuildContext context) {
    return Obx(() {
      final imageFile = selectedImages.isNotEmpty ? selectedImages.first : null;

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            if (imageFile != null) {
              // Show image in a popup or perform other actions
            } else {
              showUploadDialog(context);
            }
          },
          child: Stack(
            children: [
              if (imageFile != null)
                showImage(imageFile)
              else
                Container(
                  width: 13.h,
                  height: 15.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(Icons.photo_camera, color: Colors.grey),
                ),
              if (imageFile != null)
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      selectedImages.removeAt(0);
                      photoPath.removeAt(0);
                    },
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  void showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return UploadDialog(
          onUpload: _showBottomNavigationSheet,
          title: 'Note info:'.tr,
          contentTexts: [
            'Photos width should be  355pixel-500pixel and height should be  485 pixel-  500 pixel.'
                .tr,
            'Headphones, wireless hands-free devices or similar items are not acceptable in your photo.'
                .tr,
            'Taken within the last  6 months to reflect your current appearance.'
                .tr,
          ],
          imagePath: AppAssets.passportImage,
        );
      },
    );
  }

  void _showBottomNavigationSheet() {
    Get.bottomSheet(
      backgroundColor: AppColors.whiteOff,
      Container(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera, color: AppColors.primary),
              title: Text(
                'Pick from Camera',
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: AppColors.grayDark,
                ),
              ),
              onTap: () {
                Get.back();
                _pickFromCamera();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: AppColors.primary),
              title: Text(
                'Pick from Gallery',
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: AppColors.grayDark,
                ),
              ),
              onTap: () {
                Get.back();
                _pickFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pickFromCamera() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      final File file = File(image.path);
      selectedImages.add(file);
      photoPath.add(image.path);
    }
  }

  void _pickFromGallery() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final File file = File(image.path);
      selectedImages.add(file);
      photoPath.add(image.path);
    }
  }

  Widget showImage(File file) {
    return Container(
      width: 26.w,
      height: 15.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.file(file, fit: BoxFit.cover),
      ),
    );
  }
}
