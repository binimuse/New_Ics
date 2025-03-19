import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_origin_id_controller.dart';

class NewOriginIdView extends GetView<NewOriginIdController> {
  const NewOriginIdView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewOriginIdView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NewOriginIdView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
