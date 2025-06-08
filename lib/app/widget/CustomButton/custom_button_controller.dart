import 'package:get/get.dart';

class CustomButtonController extends GetxController {
  RxBool isPressed = false.obs;
  RxBool isLoading = false.obs;

  void onPressed() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    Get.toNamed('/menu-scan');
    Get.snackbar('Berhasil', 'Silahkan cek tulisanmu!');
  }
}
