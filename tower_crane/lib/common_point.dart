import 'dart:math';

import 'package:equations/equations.dart';
import 'package:flutter/foundation.dart';

class CommonPoint {
  static MyPoint findCommonPoint(
      {@required LinearEquation firstEquation, @required LinearEquation secondEquation}) {
    final luSolver = LUSolver(
      equations: [
        [firstEquation.xCoefficient, -1],
        [secondEquation.xCoefficient, -1],
      ],
      constants: [firstEquation.constant, secondEquation.constant],
    );
    List<double> result = luSolver.solve();
    MyPoint commonPoint = MyPoint(result[0], result[1]);
    return commonPoint;
  }
}

class LinearEquation {
  final MyPoint firstPoint;
  final MyPoint secondPoint;

  LinearEquation(this.firstPoint, this.secondPoint);

  double get xCoefficient =>
      (secondPoint.y - firstPoint.y) / (secondPoint.x - firstPoint.x);
  double get constant =>
      ((secondPoint.y - firstPoint.y) *
          firstPoint.x /
          (secondPoint.x - firstPoint.x)) -
      firstPoint.y;
}

class MyPoint{
  final double x;
  final double y;
  MyPoint(this.x, this.y);
}
