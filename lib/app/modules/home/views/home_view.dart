import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_alphabet/app/widget/CustomButton/custom_button.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: const Text(
                'Deteksi Tulisan anda. \n'
                'Dan biarkan sistem kami yang membacanya!.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Mulai Sekarang!',
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
