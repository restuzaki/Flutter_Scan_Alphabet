import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_alphabet/app/widget/CustomButton/custom_button_controller.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final CustomButtonController controller = Get.put(CustomButtonController());

  CustomButton({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTapDown: (_) => controller.isPressed.value = true,
        onTapUp: (_) {
          controller.isPressed.value = false;
          controller.onPressed();
        },
        onTapCancel: () => controller.isPressed.value = false,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: controller.isLoading.value ? 50 : 200,
          height: 50,
          decoration: BoxDecoration(
            color: controller.isPressed.value ? color.withOpacity(0.7) : color,
            borderRadius: BorderRadius.circular(
              controller.isPressed.value ? 20 : 10,
            ),
            boxShadow: [
              if (!controller.isPressed.value)
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
            ],
          ),
          child: Center(
            child: controller.isLoading.value
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
