import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/feedback_page_controller.dart';

class FeedbackPageView extends GetView<FeedbackPageController> {
  const FeedbackPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FeedbackPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FeedbackPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
