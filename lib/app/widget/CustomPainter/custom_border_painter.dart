import 'package:flutter/material.dart';

class BorderPainter extends CustomPainter {
  final double borderWidth;
  final double borderRadius;
  final double cornerLength;

  BorderPainter({
    this.borderWidth = 4.0,
    this.borderRadius = 0,
    this.cornerLength = 30.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    final double x1 = 0;
    final double y1 = 0;
    final double x2 = size.width;
    final double y2 = size.height;

    // Sudut Kiri Atas
    canvas.drawLine(Offset(x1, y1), Offset(x1 + cornerLength, y1), paint);
    canvas.drawLine(Offset(x1, y1), Offset(x1, y1 + cornerLength), paint);

    // Sudut Kanan Atas
    canvas.drawLine(Offset(x2, y1), Offset(x2 - cornerLength, y1), paint);
    canvas.drawLine(Offset(x2, y1), Offset(x2, y1 + cornerLength), paint);

    // Sudut Kiri Bawah
    canvas.drawLine(Offset(x1, y2), Offset(x1 + cornerLength, y2), paint);
    canvas.drawLine(Offset(x1, y2), Offset(x1, y2 - cornerLength), paint);

    // Sudut Kanan Bawah
    canvas.drawLine(Offset(x2, y2), Offset(x2 - cornerLength, y2), paint);
    canvas.drawLine(Offset(x2, y2), Offset(x2, y2 - cornerLength), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
