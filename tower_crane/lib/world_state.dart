import 'dart:ui';

import 'package:tower_crane/logic/logicZDown.dart';
import 'package:tower_crane/stupid_constants.dart';
import 'package:tower_crane/ui/settings/simul_listener.dart';
import './ui/responsive_size.dart';

class WorldState {
  static double shipX = 585.0, shipY = 200.0, shipZ = 278.0;
  static double waveZ = 468.0;
  static Function(double) waveFunction = WaveFunctionsHelper.functions[0];
  static double windDirection = 0;
  static double windSpeed = 0;
  static int ropeLength = 40;

  static bool isSimulated = false;

  static double ropeEndX = 585.0;
  static double ropeEndY = 200.0;
  static double ropeEndZ = 70.0;

  static void setRopeCoords(double ropeEndX, double ropeEndY, double ropeEndZ) {
    WorldState.ropeEndX = ropeEndX;
    WorldState.ropeEndY = ropeEndY;
    WorldState.ropeEndZ = ropeEndZ;
    WorldState.containerBoxX = ropeEndX;
    WorldState.containerBoxY = ropeEndY;
    WorldState.containerBoxZ = ropeEndZ + ContainerBoxDimensions.height;
  }

  static void setIdealRopeCoords(
      double ropeEndX, double ropeEndY, double ropeEndZ) {
    WorldState.idealRopeEndX = ropeEndX;
    WorldState.idealRopeEndY = ropeEndY;
    WorldState.idealRopeEndZ = ropeEndZ;
  }

  static double idealRopeEndX = ropeEndX;
  static double idealRopeEndY = ropeEndY;
  static double idealRopeEndZ = ropeEndZ;

  static var boxPlaces = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  static List<Offset> targetCenters = [];
  static int currentTarget = 0;

  static double carriageX = 585.0,
      carriageY = 200.0,
      carriageZ = CarriageDimensions.height.toDouble();

  static double containerBoxX = ropeEndX,
      containerBoxY = ropeEndY,
      containerBoxZ = ropeEndZ + ContainerBoxDimensions.height;

  static void startSimulation() {
    WorldState.isSimulated = true;
    SimulationListener.streamController.add(WorldState.isSimulated);
  }

  static void finishSimulation() {
    boxPlaces[currentTarget]++;
    while (boxPlaces[currentTarget % 12] == 4) {
      currentTarget++;
    }
    currentTarget = currentTarget % 12;
    WorldState.carriageX = targetCenters[currentTarget].dx.antiw;
    WorldState.carriageY = targetCenters[currentTarget].dy.antih;
    WorldState.setRopeCoords(
        WorldState.carriageX, WorldState.carriageY, WorldState.ropeEndZ);
    ropeEndX = targetCenters[currentTarget].dx.antiw;
    ropeEndY = targetCenters[currentTarget].dy.antih;
    ropeEndZ = 70;
    WorldState.isSimulated = false;
    SimulationListener.streamController.add(WorldState.isSimulated);
  }


  static double containerDownVelocity = 0;
  static double containerUpVelocity = 0;

  static double carriageXVelocity = 0;
  static double carriageYVelocity = 0;

  static double containerToShipDistance = 118;
  static double containerSpeedDifference = 45;


  static double oldSpeed=0;

}
