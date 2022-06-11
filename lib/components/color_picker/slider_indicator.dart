import 'package:flutter/material.dart';

class SliderIndicatorPainter extends CustomPainter {
  final double position;
  final Color currentColor;

  SliderIndicatorPainter(this.position, this.currentColor);
  
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(position, size.height / 2), 12, Paint()..color = Colors.white);
    canvas.drawCircle(
        Offset(position, size.height / 2), 8, Paint()..color = currentColor);
  }
@override
  bool shouldRepaint(SliderIndicatorPainter old) {
    return true;
  }
}