import 'dart:math';

import 'package:tower_crane/physics/point2d.dart';

double _radianConverter(double degree) {
  return degree * 180 / pi;
}

class Physics {
  static int xInitValue = 585;
  static int yInitValue = 200;
  static int marginTop = 80;
  static int ropeLength = 40;
  static double directionValue = 0; // alfa
  static double speedValue = 0; // betta
  static List<Point2d> containerMovement() {
    double zCoordTemp = ropeLength * cos(_radianConverter(speedValue));
    double zCoordinate = marginTop + zCoordTemp;

    double xCoordTemp =
        ropeLength * sin(_radianConverter(speedValue)); // радиус окружности
    double xCoordTemp2 =
        xCoordTemp * sin(_radianConverter(directionValue)); // смещение по Х
    double xCoordinate = xInitValue + xCoordTemp2;
    Point2d xzPoint = new Point2d(xCoordinate, zCoordinate);

    double yCoordTemp = xCoordTemp; // радиус окружности
    double yCoordTemp2 =
        yCoordTemp * cos(_radianConverter(directionValue)); // смещение по Y
    double yCoordinate = yInitValue + yCoordTemp2;
    Point2d xyPoint = new Point2d(xCoordinate, yCoordinate);

    return []..add(xzPoint)..add(xyPoint);
  }
}
