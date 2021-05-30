import 'package:flutter/material.dart';
import 'package:tower_crane/stupid_constants.dart';

import '../../world_state.dart';
import '../responsive_size.dart';

class ShipSidePainter extends CustomPainter {
  double rads;

  @override
  void paint(Canvas canvas, Size size) {
    Paint balkPainter = Paint()..color = Colors.black;
    Paint wavePainter = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.fill
      ..color = Color(0xFF13acd6);
    Paint shipPainter = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.fill
      ..color = Color(0xFF000060);

    var ship = Path();
    var leftPart = WorldState.shipX - (ShipDimensions.length / 2);
    var rightPart = leftPart + ShipDimensions.length;
    var bottomPart = WorldState.shipZ + ShipDimensions.height;
    ship.moveTo(leftPart.w, WorldState.shipZ.h);
    ship.lineTo(rightPart.w, WorldState.shipZ.h);
    ship.lineTo((rightPart - ShipDimensions.sternBevel).w, bottomPart.h);
    ship.lineTo((leftPart + ShipDimensions.sternBevel).w, bottomPart.h);
    ship.close();

    var wave = Path();
    wave.moveTo(0, WorldState.waveZ.h);
    wave.lineTo(0, (WorldState.waveZ - WaveDimensions.height).h);
    var firstControlPoint =
        Offset(283.w, (WorldState.waveZ - WaveDimensions.height + 40).h);
    var firstEndPoint =
        Offset(566.w, (WorldState.waveZ - WaveDimensions.height).h);
    var secondControlPoint =
        Offset(889.w, (WorldState.waveZ - WaveDimensions.height - 40).h);
    var secondEndPoint = Offset(PainterDimensions.width.w,
        (WorldState.waveZ - WaveDimensions.height).h);

    wave.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    wave.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    wave.lineTo(PainterDimensions.width.w, WorldState.waveZ);
    wave.close();

    canvas.drawPath(ship, shipPainter);
    canvas.drawPath(wave, wavePainter);



    var balkLeftTop = Offset(0, 0);
    var balkRightBottom = Offset(1172.w, 20.h);
    Rect balk = Rect.fromPoints(balkLeftTop, balkRightBottom);
    canvas.drawRect(balk, balkPainter);


    Rect containerBox = Rect.fromLTWH((WorldState.containerBoxX - ContainerBoxDimensions.length/2).w, (WorldState.containerBoxZ - ContainerBoxDimensions.height).h,
        ContainerBoxDimensions.length.w, ContainerBoxDimensions.height.h);

    Paint boxPainter = Paint()..color = Color(0xFF7A009A);
    Paint strokePainter = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..color = Color(0xFF000000);

    canvas.drawRect(containerBox, boxPainter);
    canvas.drawRect(containerBox, strokePainter);

    var rope = Path();
    rope.moveTo(WorldState.carriageX.w, WorldState.carriageZ.h);
    rope.lineTo(WorldState.ropeEndX.w, WorldState.ropeEndZ.h);
    canvas.drawPath(rope, strokePainter);

    Rect carriage = Rect.fromLTWH((WorldState.carriageX - CarriageDimensions.length/2).w, 0,
        CarriageDimensions.length.w, CarriageDimensions.height.h);

    Paint carriagePainter = Paint()..color = Color(0xFF0CBB95);

    canvas.drawRect(carriage, carriagePainter);



    var leftContPart = WorldState.shipX - (ContainerBoxDimensions.length * 3);
    Paint solidPainter = Paint()
      ..style = PaintingStyle.fill
      ..color = Color(0xFFFFFFFF);

    for (int i = 0; i < 12; i++) {
      var x = leftContPart + ContainerBoxDimensions.length * (i % 6);
      for (int j = 0; j < WorldState.boxPlaces[i]; j++) {
        var z = WorldState.shipZ - ContainerBoxDimensions.height * j;
        switch (j+1) {
          case 0:
            solidPainter.color = Color(0xFFFFFFFF);
            break;
          case 1:
            solidPainter.color = Color(0xFFFFFF00);
            break;
          case 2:
            solidPainter.color = Color(0xFFFFAA00);
            break;
          case 3:
            solidPainter.color = Color(0xFFFF0000);
            break;
          case 4:
            solidPainter.color = Color(0xFFAA0000);
            break;
        }
        var rect = Rect.fromPoints(
            Offset(x.w, z.h),
            Offset((x + ContainerBoxDimensions.length).w,
                (z - ContainerBoxDimensions.height).h));
        canvas.drawRect(rect, solidPainter);
        canvas.drawRect(rect, strokePainter);
      }
    }
  }

  ShipSidePainter(this.rads);

  @override
  bool shouldRepaint(ShipSidePainter oldDelegate) =>
      oldDelegate.rads != this.rads;

  @override
  bool shouldRebuildSemantics(ShipSidePainter oldDelegate) => false;
}
