import 'dart:math';

class StaticFun{
  static Function(double) waveFunction = (double x) => sin(x);
  static double yOffset = 0.0;
}