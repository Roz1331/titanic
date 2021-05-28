import 'package:flutter/material.dart';
import '../responsive_size.dart';
import 'dart:ui' as ui;

class ShipTopPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint seaPainter = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.fill
      ..color = Color(0xFF13acd6);
    Paint painter = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.fill
      ..color = Color(0xFF000060);

    var ship = Path();
    ship.moveTo(41.w, 198.h);
    ship.lineTo(121.w, 79.h);
    ship.lineTo(1051.w, 79.h);
    ship.lineTo(1132.w, 198.h);
    ship.lineTo(1051.w, 318.h);
    ship.lineTo(121.w, 318.h);

    var leftTop = Offset(0, 0);
    var rightBottom = Offset(1172.w, 357.h);

    canvas.drawRect(Rect.fromPoints(leftTop, rightBottom), seaPainter);
    canvas.drawPath(ship, painter);
  }

  @override
  bool shouldRepaint(ShipTopPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ShipTopPainter oldDelegate) => false;
}
