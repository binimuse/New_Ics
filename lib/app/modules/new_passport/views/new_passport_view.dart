import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_passport_controller.dart';

class NewPassportView extends GetView<NewPassportController> {
  const NewPassportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewPassportView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NewPassportView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
