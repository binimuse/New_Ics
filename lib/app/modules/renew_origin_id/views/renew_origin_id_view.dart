import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/renew_origin_id_controller.dart';

class RenewOriginIdView extends GetView<RenewOriginIdController> {
  const RenewOriginIdView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RenewOriginIdView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RenewOriginIdView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
