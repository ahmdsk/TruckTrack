import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/master_data_pengguna_controller.dart';

class MasterDataPenggunaView extends GetView<MasterDataPenggunaController> {
  const MasterDataPenggunaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MasterDataPenggunaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MasterDataPenggunaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
