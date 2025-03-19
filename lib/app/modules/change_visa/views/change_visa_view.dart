import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_visa_controller.dart';

class ChangeVisaView extends GetView<ChangeVisaController> {
  const ChangeVisaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeVisaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChangeVisaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
