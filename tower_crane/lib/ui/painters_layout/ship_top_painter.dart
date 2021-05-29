import 'package:flutter/material.dart';
import '../../stupid_constants.dart';
import '../../world_state.dart';
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
    var leftPart = WorldState.shipX - (ShipDimensions.length/2);
    var rightPart = leftPart + ShipDimensions.length;
    var topPart = WorldState.shipY - (ShipDimensions.width/2);
    var bottomPart = WorldState.shipY + (ShipDimensions.width/2);
    ship.moveTo(leftPart.w, WorldState.shipY.h);
    ship.lineTo((leftPart + ShipDimensions.sternBevel).w, topPart.h);
    ship.lineTo((rightPart - ShipDimensions.sternBevel).w, topPart.h);
    ship.lineTo(rightPart.w, WorldState.shipY.h);
    ship.lineTo((rightPart - ShipDimensions.sternBevel).w, bottomPart.h);
    ship.lineTo((leftPart + ShipDimensions.sternBevel).w, bottomPart.h);

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
