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
    ship.moveTo(41.width, 198.height);
    ship.lineTo(121.width, 79.height);
    ship.lineTo(1051.width, 79.height);
    ship.lineTo(1132.width, 198.height);
    ship.lineTo(1051.width, 318.height);
    ship.lineTo(121.width, 318.height);

    var leftTop = Offset(0, 0);
    var rightBottom = Offset(1172.width, 357.height);

    canvas.drawRect(Rect.fromPoints(leftTop, rightBottom), seaPainter);
    canvas.drawPath(ship, painter);
  }

  @override
  bool shouldRepaint(ShipTopPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ShipTopPainter oldDelegate) => false;
}
