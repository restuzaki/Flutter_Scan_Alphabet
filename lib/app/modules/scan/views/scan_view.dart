import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan_alphabet/app/modules/scan/controllers/scan_controller.dart';

import 'package:scan_alphabet/app/widget/CustomPainter/custom_border_painter.dart';

class ScanView extends StatefulWidget {
  @override
  _ScanViewState createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  final ScanController controller = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                MobileScanner(
                  controller: controller.cameraController,
                  onDetect: controller.onDetect,
                ),
                Positioned.fill(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: MediaQuery.of(context).size.height / 3.1,
                        child: Container(color: Colors.black.withOpacity(0.5)),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: MediaQuery.of(context).size.height / 3.1,
                        child: Container(color: Colors.black.withOpacity(0.5)),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 3.1,
                        bottom: MediaQuery.of(context).size.height / 3.1,
                        left: 0,
                        width: (MediaQuery.of(context).size.width - 320) / 2,
                        child: Container(color: Colors.black.withOpacity(0.5)),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 3.1,
                        bottom: MediaQuery.of(context).size.height / 3.1,
                        right: 0,
                        width: (MediaQuery.of(context).size.width - 320) / 2,
                        child: Container(color: Colors.black.withOpacity(0.5)),
                      ),
                      Center(
                        child: CustomPaint(
                          painter: BorderPainter(),
                          child: SizedBox(
                            width: 320,
                            height: MediaQuery.of(context).size.height / 5.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Obx(() => Text("Scanned Barcode: ${controller.barcodeResult}")),
          ),
        ],
      ),
    );
  }
}
