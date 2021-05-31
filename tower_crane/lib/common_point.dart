import 'dart:math';

import 'package:equations/equations.dart';
import 'package:flutter/foundation.dart';

class CommonPoint {
  static Point findCommonPoint(
      {@required LinearEquation firstEquation, @required LinearEquation secondEquation}) {
    final luSolver = LUSolver(
      equations: [
        [firstEquation.xCoefficient, -1],
        [secondEquation.xCoefficient, -1],
      ],
      constants: [firstEquation.constant, secondEquation.constant],
    );
    List<double> result = luSolver.solve();
    Point commonPoint = Point(result[0], result[1]);
    return commonPoint;
  }
}

class LinearEquation {
  final Point firstPoint;
  final Point secondPoint;

  LinearEquation(this.firstPoint, this.secondPoint);

  double get xCoefficient =>
      (secondPoint.y - firstPoint.y) / (secondPoint.x - firstPoint.x);
  double get constant =>
      ((secondPoint.y - firstPoint.y) *
          firstPoint.x /
          (secondPoint.x - firstPoint.x)) -
      firstPoint.y;
}
