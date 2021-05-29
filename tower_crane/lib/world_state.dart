import 'package:tower_crane/stupid_constants.dart';

class WorldState{
  static double shipX = 585.0, shipY = 200.0, shipZ = 278.0;
  static double waveZ = 468.0;
  static Function(double) waveFunction = WaveFunctionsHelper.functions[0];
  static double windDirection = 0;
  static double windSpeed = 0;
  static int ropeLength = 40;
}