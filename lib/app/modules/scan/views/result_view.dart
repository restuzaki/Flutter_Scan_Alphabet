import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_alphabet/app/modules/scan/controllers/scan_controller.dart';

class ResultView extends StatelessWidget {
  final ScanController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hasil Prediksi')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Huruf Terprediksi:', style: TextStyle(fontSize: 20)),
            Obx(() => Text(controller.prediction.value,
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold))),
            SizedBox(height: 20),
            Text('Probabilitas:'),
            Obx(() => Column(
                  children: controller.probabilities
                      .asMap()
                      .entries
                      .map((e) => ListTile(
                            title: Text('${String.fromCharCode(65 + e.key)}:'),
                            trailing:
                                Text('${(e.value * 100).toStringAsFixed(1)}%'),
                          ))
                      .toList(),
                )),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
