import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/visa_extantion_controller.dart';

class VisaExtantionView extends GetView<VisaExtantionController> {
  const VisaExtantionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VisaExtantionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'VisaExtantionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
