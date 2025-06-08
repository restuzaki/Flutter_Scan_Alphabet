import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_alphabet/app/modules/scan/controllers/scan_controller.dart';

class ScanView extends StatelessWidget {
  final ScanController controller = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan Huruf')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => controller.imageFile.value != null
                ? Image.file(controller.imageFile.value!, height: 200)
                : Text('Belum ada gambar')),
            SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: controller.pickImage,
                    child: Text('Ambil Gambar'),
                  )),
          ],
        ),
      ),
    );
  }
}
