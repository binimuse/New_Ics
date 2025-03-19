import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/renew_passport_controller.dart';

class RenewPassportView extends GetView<RenewPassportController> {
  const RenewPassportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RenewPassportView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RenewPassportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
