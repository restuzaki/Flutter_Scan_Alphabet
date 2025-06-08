import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ScanController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  Rx<File?> imageFile = Rx<File?>(null);
  RxBool isLoading = false.obs;
  RxString prediction = ''.obs;
  RxList<double> probabilities = <double>[].obs;

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        imageFile.value = File(image.path);
        await _processImage(File(image.path));
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil gambar: ${e.toString()}');
    }
  }

  Future<void> _processImage(File image) async {
    try {
      isLoading.value = true;

      // 1. Konversi gambar ke 28x28 grayscale & flatten
      // [Implementasi preprocessing gambar disesuaikan dengan kebutuhan model]
      List<double> pixels = await _convertImageToPixels(image);

      // 2. Kirim ke API
      final response = await http.post(
        Uri.parse('http://192.168.18.19:8000/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'pixels': pixels}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        prediction.value = data['prediction'];
        probabilities.value = List<double>.from(data['probabilities']);
        Get.toNamed('/result');
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Prediksi gagal: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<double>> _convertImageToPixels(File image) async {
    // Implementasi konversi gambar ke array 784 pixel
    // Contoh sederhana (harus disesuaikan dengan preprocessing model Anda):
    // 1. Resize ke 28x28
    // 2. Konversi ke grayscale
    // 3. Normalisasi nilai pixel
    return List<double>.filled(784, 0.0); // Ganti dengan implementasi aktual
  }
}
