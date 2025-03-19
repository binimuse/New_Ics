import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/check_status_controller.dart';

class CheckStatusView extends GetView<CheckStatusController> {
  const CheckStatusView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckStatusView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CheckStatusView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
