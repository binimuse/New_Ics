import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/evisa_controller.dart';

class EvisaView extends GetView<EvisaController> {
  const EvisaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EvisaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EvisaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
