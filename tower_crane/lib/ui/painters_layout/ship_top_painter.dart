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
    FieldPainter().paint(canvas, size);
  }

  @override
  bool shouldRepaint(ShipTopPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ShipTopPainter oldDelegate) => false;
}

class FieldPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint painter = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Color(0xFFFFFFFF);

    var leftPart = WorldState.shipX - (ContainerBoxDimensions.length * 3);
    var topPart = WorldState.shipY - ContainerBoxDimensions.width;

    //canvas.drawRect(Rect.fromPoints(Offset(10, 10), Offset(50, 50)), painter);
    for (int i = 0; i < 12; i++){
      var x = leftPart + ContainerBoxDimensions.length * (i % 6);
      var y = topPart + ContainerBoxDimensions.width * (i ~/ 6);
      if(WorldState.boxPlaces[i] > 0) {
        painter.style = PaintingStyle.fill;
      }
      canvas.drawRect(Rect.fromPoints(Offset(x.w,y.h), Offset((x + ContainerBoxDimensions.length).w, (y + ContainerBoxDimensions.width).h)), painter);
      painter.style = PaintingStyle.stroke;
    }
  }

  @override
  bool shouldRepaint(ShipTopPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ShipTopPainter oldDelegate) => false;
}
