import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/complain_page_controller.dart';

class ComplainPageView extends GetView<ComplainPageController> {
  const ComplainPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ComplainPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ComplainPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
