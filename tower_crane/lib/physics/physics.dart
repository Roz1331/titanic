import 'dart:math';

import 'package:tower_crane/physics/point2d.dart';
import 'package:tower_crane/world_state.dart';

double _radianConverter(double degree) {
  return degree * 180 / pi;
}

class Physics {
  static int marginTop = 80;

  static List<Point2d> containerMovement() {
    double zCoordTemp = WorldState.ropeLength * cos(_radianConverter(WorldState.windSpeed));
    double zCoordinate = marginTop + zCoordTemp;

    double xCoordTemp =
        WorldState.ropeLength * sin(_radianConverter(WorldState.windSpeed)); // радиус окружности
    double xCoordTemp2 =
        xCoordTemp * sin(_radianConverter(WorldState.windDirection)); // смещение по Х
    double xCoordinate = WorldState.shipX + xCoordTemp2;
    Point2d xzPoint = new Point2d(xCoordinate, zCoordinate);

    double yCoordTemp = xCoordTemp; // радиус окружности
    double yCoordTemp2 =
        yCoordTemp * cos(_radianConverter(WorldState.windDirection)); // смещение по Y
    double yCoordinate = WorldState.shipY + yCoordTemp2;
    Point2d xyPoint = new Point2d(xCoordinate, yCoordinate);

    return []..add(xzPoint)..add(xyPoint);
  }
}
