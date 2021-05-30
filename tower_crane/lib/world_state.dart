import 'package:tower_crane/stupid_constants.dart';
import 'package:tower_crane/ui/settings/simul_listener.dart';

class WorldState {
  static double shipX = 585.0, shipY = 200.0, shipZ = 278.0;
  static double waveZ = 468.0;
  static Function(double) waveFunction = WaveFunctionsHelper.functions[0];
  static double windDirection = 0;
  static double windSpeed = 0;
  static int ropeLength = 40;

  static bool isSimulated = false;

  static double ropeEndX;
  static double ropeEndY;
  static double ropeEndZ;

  static var boxPlaces = [1, 4, 0, 4, 2, 0, 0, 0, 0, 4, 1, 3];
  static int currentTarget = 0;

  static double carriageX = 585.0,
      carriageY = 200.0,
      carriageZ = CarriageDimensions.height.toDouble();

  static void startSimulation() {
    WorldState.isSimulated = true;
    SimulationListener.streamController.add(WorldState.isSimulated);
  }

  static void finishSimulation() {
    WorldState.isSimulated = false;
    SimulationListener.streamController.add(WorldState.isSimulated);
  }
}
