import 'package:flutter/material.dart';
import 'package:tower_crane/ui/settings/wave_settings.dart';

import '../responsive_size.dart';

class ShipSidePainter extends CustomPainter {
  double yOffset = 0.0;
  @override
  void paint(Canvas canvas, Size size) {
    Paint wavePainter = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.fill
      ..color = Color(0xFF13acd6);
    Paint shipPainter = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.fill
      ..color = Color(0xFF000060);

    var ship = Path();
    ship.moveTo(81.width, 278.height+ yOffset );
    ship.lineTo(1091.width, 278.height+ yOffset );
    ship.lineTo(1011.width, 357.height+ yOffset );
    ship.lineTo(162.width, 357.height+ yOffset );
    ship.close();

    var wave = Path();
    wave.moveTo(0, 754.height+ yOffset );
    wave.lineTo(0, (675 - 357).height+ yOffset );
    var firstControlPoint = Offset(283.width, (714 - 357).height+ yOffset );
    var firstEndPoint = Offset(566.width, (675 - 357).height+ yOffset );
    var secondControlPoint =
        Offset(889.width, (635 - 357).height+ yOffset );
    var secondEndPoint = Offset(1172.width, (675 - 357).height+ yOffset );

    wave.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    wave.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    wave.lineTo(1172.width, 754.height + yOffset );
    wave.close();

    canvas.drawPath(ship, shipPainter);
    canvas.drawPath(wave, wavePainter);
  }

  @override
  bool shouldRepaint(ShipSidePainter oldDelegate) => oldDelegate.yOffset != this.yOffset;

  @override
  bool shouldRebuildSemantics(ShipSidePainter oldDelegate) => false;
}
