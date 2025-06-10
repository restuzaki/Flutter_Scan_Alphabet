import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_alphabet/app/modules/scan/controllers/scan_controller.dart';

class ScanView extends StatelessWidget {
  final ScanController controller = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Scan Huruf'),
        backgroundColor: Colors.white,
      ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 4,
                    ),
                    child: Text(
                      'Ambil Gambar',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            SizedBox(height: 10),
            SizedBox(height: 5),
            SizedBox(
              width: 150,
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 2,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    "atau",
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 2,
                      indent: 10,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => controller.isLoading.value
                ? SizedBox()
                : ElevatedButton(
                    onPressed: controller.pickImageFromGallery,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      elevation: 4,
                    ),
                    child: Text(
                      'Pilih Gambar dari Galeri',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
