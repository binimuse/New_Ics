import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/residency_controller.dart';

class ResidencyView extends GetView<ResidencyController> {
  const ResidencyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResidencyView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ResidencyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
