import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color=(Colors.white);
    var path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, 100), radius: 102));
    canvas.drawPath(path, paint);
    paint = Paint()..color=(Colors.grey);
    path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, 100), radius: 100));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
