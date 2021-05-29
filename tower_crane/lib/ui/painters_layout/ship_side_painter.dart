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
    var leftPart = WorldState.shipX - (ShipDimensions.length/2);
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
    var firstControlPoint = Offset(283.w, (WorldState.waveZ - WaveDimensions.height + 40).h);
    var firstEndPoint = Offset(566.w, (WorldState.waveZ - WaveDimensions.height).h);
    var secondControlPoint =
        Offset(889.w, (WorldState.waveZ - WaveDimensions.height - 40).h );
    var secondEndPoint = Offset(PainterDimensions.width.w, (WorldState.waveZ - WaveDimensions.height).h);

    wave.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    wave.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    wave.lineTo(PainterDimensions.width.w, WorldState.waveZ );
    wave.close();

    canvas.drawPath(ship, shipPainter);
    canvas.drawPath(wave, wavePainter);

    var balkLeftTop = Offset(0, 0);
    var balkRightBottom = Offset(1172.w, 20.h);
    Rect balk = Rect.fromPoints(balkLeftTop, balkRightBottom);
    canvas.drawRect(balk, balkPainter);

    Rect carriage = Rect.fromLTWH(WorldState.carriageX.w, 0, CarriageDimensions.length.w, CarriageDimensions.height.h);

    Paint carriagePainter = Paint()..color = Colors.yellow;

    canvas.drawRect(carriage, carriagePainter);
  }

  ShipSidePainter(this.rads);

  @override
  bool shouldRepaint(ShipSidePainter oldDelegate) => oldDelegate.rads != this.rads;

  @override
  bool shouldRebuildSemantics(ShipSidePainter oldDelegate) => false;
}
