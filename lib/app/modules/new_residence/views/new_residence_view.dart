import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_residence_controller.dart';

class NewResidenceView extends GetView<NewResidenceController> {
  const NewResidenceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewResidenceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NewResidenceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
