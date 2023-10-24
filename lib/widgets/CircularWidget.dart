import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class CirclesWidget extends StatelessWidget {
  const CirclesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(80.w, 80.h), // Adjust the size as needed
      painter: CirclePainter(),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xff8B8BAE).withOpacity(0.5); // Purple color with 50% opacity
 final Paint paint2 = Paint()
      ..color = const Color(0xff8B8BAE).withOpacity(0.5);
    const center = Offset(50, 30); // Top-left corner (more left)
    final radius = min(size.width / 4, size.height / 2);

    final center2 = Offset(center.dx + radius * 0.5 - 70, center.dy + radius * 0.85);

    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(center2, radius, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}