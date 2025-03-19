import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:new_ics/app/theme/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: AppColors.whiteOff),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  controller.splasehimage,
                  fit: BoxFit.contain,
                  width: 80.w,
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
