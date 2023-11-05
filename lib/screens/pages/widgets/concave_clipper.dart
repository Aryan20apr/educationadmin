import 'package:flutter/material.dart';

class ConcaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double concavity = 20; // Adjust the concavity as needed

    var path = Path()
      ..lineTo(0, size.height)
      ..lineTo(0, concavity)
      ..quadraticBezierTo(size.width / 2, concavity * 2, size.width, concavity)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
