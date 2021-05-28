import 'dart:math';

class StaticFun{
  static Function(double) waveFunction = WaveFunctionsHelper.functions[0];
  static double yOffset = 0.0;
}

class WaveFunctionsHelper {
  static List<Function(double)> functions = [
    (double x) => sin(x),
    (double x) => sin(8*x),
    (double x) => sin(x/2),
  ];

  static List<String> functionStrings = [
    "sin(x)",
    "sin(8*x)",
    "sin(x/2),"
  ];
}