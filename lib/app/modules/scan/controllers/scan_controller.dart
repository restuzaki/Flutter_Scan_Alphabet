import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan_alphabet/app/model/api_makanan.dart';

class ScanController extends GetxController {
  final MobileScannerController cameraController = MobileScannerController();
  var barcodeResult = "Scan a product".obs;
  var productData = {}.obs;

  void onDetect(BarcodeCapture barcode) async {
    if (barcode.barcodes.isNotEmpty) {
      final String scannedBarcode = barcode.barcodes.first.rawValue ?? "";
      barcodeResult.value = scannedBarcode;
      fetchProductData(scannedBarcode);
    }
  }

  Future<void> fetchProductData(String barcode) async {
    ApiMakananService apiService = ApiMakananService();
    Map<String, dynamic>? data = await apiService.getProductData(barcode);

    if (data != null && data['product'] != null) {
      productData.value = data['product'];
      checkSugarIntake(productData['nutriments']['sugars_100g'] ?? 0.0);
    } else {
      Get.snackbar("Error", "Produk tidak ditemukan");
    }
  }

  void checkSugarIntake(double sugarAmount) {
    const double MAX_SUGAR_LIMIT = 25.0;

    Get.defaultDialog(
      title: "Hasil Scan",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Nama Produk: ${productData['product_name'] ?? 'Unknown'}"),
          Text("Kandungan Gula: ${sugarAmount} g/100g"),
          const SizedBox(height: 10),
          sugarAmount < MAX_SUGAR_LIMIT
              ? const Icon(Icons.check_circle, color: Colors.green, size: 50)
              : const Icon(Icons.cancel, color: Colors.red, size: 50),
        ],
      ),
      textConfirm: "OK",
      onConfirm: () => Get.toNamed('/home'),
    );
  }
}
