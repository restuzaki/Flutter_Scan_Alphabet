import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

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

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageFile.value = File(image.path);
        await _processImage(File(image.path));
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memilih gambar: ${e.toString()}');
    }
  }

  Future<void> _processImage(File image) async {
    try {
      isLoading.value = true;

      // Preprocessing gambar jadi list pixel (0 atau 255)
      List<double> pixels = await _convertImageToPixels(image);

      // Kirim ke API
      final response = await http.post(
        Uri.parse('http://192.168.1.51:8000/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'pixels': pixels}),
      );

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        final data = jsonDecode(response.body);
        prediction.value = data['prediction'];
        probabilities.value = List<double>.from(data['probabilities']);
        Get.toNamed('/result');
      } else {
        print('API Error: ${response.body}');
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Prediksi gagal: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<double>> _convertImageToPixels(File image) async {
    img.Image? originalImage = img.decodeImage(await image.readAsBytes());

    if (originalImage == null) {
      throw Exception("Gagal mengurai gambar");
    }

    // Resize gambar ke 28x28
    img.Image resized = img.copyResize(originalImage, width: 28, height: 28);

    List<double> pixels = [];

    for (int y = 0; y < resized.height; y++) {
      for (int x = 0; x < resized.width; x++) {
        final pixel = resized.getPixel(x, y);

        // Ambil nilai R, G, B
        final r = pixel.r;
        final g = pixel.g;
        final b = pixel.b;

        // Hitung luminansi
        final luminance = ((r + g + b) / 3).floor();

        // Inversi
        final inverted = 255 - luminance;

        if (inverted < 128) {
          pixels.add(0.0); // putih
        } else {
          pixels.add(inverted / 1.0); // hitam
        }
        // pixels.add(inverted / 1.0);
      }
    }

    if (pixels.length != 784) {
      throw Exception("Ukuran piksel tidak 784 setelah preprocessing!");
    }

    return pixels;
  }
}
