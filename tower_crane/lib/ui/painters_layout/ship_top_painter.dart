import 'package:flutter/material.dart';
import '../../stupid_constants.dart';
import '../../world_state.dart';
import '../responsive_size.dart';
import 'dart:ui' as ui;

class ShipTopPainter extends CustomPainter {
  final Offset tappedPosition;
  ShipTopPainter(this.tappedPosition);

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
    FieldPainter(tappedPosition).paint(canvas, size);
  }

  @override
  bool shouldRepaint(ShipTopPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ShipTopPainter oldDelegate) => false;
}

class FieldPainter extends CustomPainter{
  final Offset tappedPosition;
  FieldPainter(this.tappedPosition);
  var containerCoords = [];

  @override
  void paint(Canvas canvas, Size size) {
    Paint solidPainter = Paint()
      ..style = PaintingStyle.fill
      ..color = Color(0xFFFFFFFF);
    Paint strokePainter = Paint()
    ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..color = Color(0xFF000000);

    var leftPart = WorldState.shipX - (ContainerBoxDimensions.length * 3);
    var topPart = WorldState.shipY - ContainerBoxDimensions.width;

    //canvas.drawRect(Rect.fromPoints(Offset(10, 10), Offset(50, 50)), painter);
    for (int i = 0; i < 12; i++){
      var x = leftPart + ContainerBoxDimensions.length * (i % 6);
      var y = topPart + ContainerBoxDimensions.width * (i ~/ 6);
      switch(WorldState.boxPlaces[i]){
        case 0: solidPainter.color = Color(0xFFFFFFFF); break;
        case 1: solidPainter.color = Color(0xFFFFFF00); break;
        case 2: solidPainter.color = Color(0xFFFFAA00); break;
        case 3: solidPainter.color = Color(0xFFFF0000); break;
        case 4: solidPainter.color = Color(0xFFAA0000); break;
      }
      var rect = Rect.fromPoints(Offset(x.w,y.h), Offset((x + ContainerBoxDimensions.length).w, (y + ContainerBoxDimensions.width).h));
      canvas.drawRect(rect, solidPainter);
      canvas.drawRect(rect, strokePainter);

      if(i == WorldState.currentTarget){
        Path cross = Path();
        Paint crossPainter = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;
        cross.moveTo((rect.center.dx - 15), (rect.center.dy - 15));
        cross.lineTo((rect.center.dx + 15), (rect.center.dy + 15));
        cross.moveTo((rect.center.dx - 15), (rect.center.dy + 15));
        cross.lineTo((rect.center.dx + 15), (rect.center.dy - 15));
        canvas.drawPath(cross, crossPainter);
      }
    }
  }

  @override
  bool shouldRepaint(ShipTopPainter oldDelegate) => oldDelegate.tappedPosition != tappedPosition;

  @override
  bool shouldRebuildSemantics(ShipTopPainter oldDelegate) => false;
}
