import 'dart:math';

import 'package:tower_crane/physics/point2d.dart';

int xInitValue = 585;
int yInitValue = 200;
int marginTop = 80;
int ropeInitLength = 40;
double directionValue = 0;
double speedValue = 0;

double _radianConverter(double degree) {
  return degree * 180 / pi;
}

class Physics {
  static List<Point2d> containerMovement(Point2d wind, double zContainer) {
    double zCoordTemp = ropeInitLength * cos(_radianConverter(speedValue));
    double zCoordinate = marginTop + zCoordTemp;
    double xCoordTemp = pow(ropeInitLength, 2) - pow(zCoordTemp, 2);
    double xCoordinate = xInitValue + xCoordTemp;

    Point2d xzPoint = new Point2d(xCoordinate, zCoordinate);

    double yCoordTemp = ropeInitLength * cos(_radianConverter(directionValue));
    double yCoordinate = yInitValue - yCoordTemp;

    xCoordTemp = pow(ropeInitLength, 2) - pow(yCoordTemp, 2);
    xCoordinate = xInitValue + xCoordTemp;

    Point2d xyPoint = new Point2d(xCoordinate, yCoordinate);

    return []..add(xzPoint)..add(xyPoint);
  }
}
