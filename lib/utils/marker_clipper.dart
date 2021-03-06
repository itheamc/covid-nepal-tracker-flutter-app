import 'package:flutter/material.dart';

class MarkerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();

    path.moveTo(w / 2, 0);
    path.quadraticBezierTo(w * 0.025, h * 0.05, w * 0.5, h);
    path.quadraticBezierTo(w * 0.975, h * 0.05, w * 0.5, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
