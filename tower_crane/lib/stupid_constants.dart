import 'dart:math';

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

class ShipDimensions{
  static int length = 1091;
  static int width = 239;
  static int height = 79;
  static int sternBevel = 80;
}

class PainterDimensions{
  static int width = 1172;
  static int height = 357;
}

class WaveDimensions{
  static int height = 150;
  static int amplitude = 20;
}

class ContainerBoxDimensions {
  static int length = 120;
  static int width = 80;
  static int height = 30;
}

class CarriageDimensions{
  static int length = 50;
  static int width = 40;
  static int height = 30;
}