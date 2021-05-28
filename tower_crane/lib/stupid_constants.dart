import 'dart:math';

class StaticFun{
  static Function(double) waveFunction = WaveFunctionsHelper.functions[0];
  static double yOffset = 0.0;
}

class WaveFunctionsHelper {
  static List<Function(double)> functions = [
    (double x) => sin(x),
    (double x) => sin(2*x) * cos(x/4),
    (double x) => pow(cos(x/2),2) * sin(2*x).abs(),
  ];

  static List<String> functionStrings = [
    "sin(x)",
    "sin(2*x) * cos(x/4)",
    "(cos(x/2))^2 * |sin(2*x)|"
  ];
}