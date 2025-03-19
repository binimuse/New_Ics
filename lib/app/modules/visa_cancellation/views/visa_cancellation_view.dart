import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/visa_cancellation_controller.dart';

class VisaCancellationView extends GetView<VisaCancellationController> {
  const VisaCancellationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VisaCancellationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'VisaCancellationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
