import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/otp_varification_controller.dart';

class OtpVarificationView extends GetView<OtpVarificationController> {
  const OtpVarificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OtpVarificationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OtpVarificationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
