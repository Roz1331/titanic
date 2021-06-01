import 'dart:math';

import 'package:tower_crane/world_state.dart';
import 'package:tower_crane/stupid_constants.dart';

double _radianConverter(double degree) {
  return degree * pi / 180;
}

bool belongToInterval(double x, double left, double right) {
  return x >= left && x < right;
}

class Physics {
  static int marginTop = 30;

  static bool _containerHasReachedIdeal() {
    return WorldState.idealRopeEndX == WorldState.ropeEndX &&
        WorldState.idealRopeEndY == WorldState.ropeEndY;
  }

  static void windAbsorbtion() {
    double k = 0.015;
    double dx = WorldState.idealRopeEndX - WorldState.ropeEndX;
      double dy = WorldState.idealRopeEndY - WorldState.ropeEndY;
    if (!_containerHasReachedIdeal()) {
      
      WorldState.setRopeCoords(
        WorldState.ropeEndX + dx * k,
        WorldState.ropeEndY + dy * k,
        WorldState.ropeEndZ,
      );
    }
  }

  //вернет лист точек конца веревки
  static void containerMovement() {
    double zCoordTemp =
        WorldState.ropeLength * cos(_radianConverter(WorldState.windSpeed));
    double zCoordinate = marginTop + zCoordTemp;

    double xCoordTemp = WorldState.ropeLength *
        sin(_radianConverter(WorldState.windSpeed)); // радиус окружности
    double xCoordTemp2 = xCoordTemp *
        sin(_radianConverter(WorldState.windDirection)); // смещение по Х
    double xCoordinate = WorldState.carriageX + xCoordTemp2;

    double yCoordTemp = xCoordTemp; // радиус окружности
    double yCoordTemp2 = yCoordTemp *
        cos(_radianConverter(WorldState.windDirection)); // смещение по Y
    double yCoordinate = WorldState.carriageY + yCoordTemp2;
    WorldState.setIdealRopeCoords(xCoordinate, yCoordinate, zCoordinate);
    windAbsorbtion();
  }

  //обнуляет ветер при достижении контейнера
  static void containerMovementWithBlocks() {
    double windDirection = WorldState.windDirection;
    
    int currentTarget = WorldState.currentTarget;

    int sector = 0;

    if (belongToInterval(windDirection, 0, 26.5) ||
        belongToInterval(windDirection, 333.5, 360)) sector = 1;
    if (belongToInterval(windDirection, 26.5, 56)) sector = 2;
    if (belongToInterval(windDirection, 56, 77.5)) sector = 3;
    if (belongToInterval(windDirection, 77.5, 102.5)) sector = 4;
    if (belongToInterval(windDirection, 102.5, 124)) sector = 5;
    if (belongToInterval(windDirection, 124, 153.5)) sector = 6;
    if (belongToInterval(windDirection, 153.5, 206.5)) sector = 7;
    if (belongToInterval(windDirection, 206.5, 236)) sector = 8;
    if (belongToInterval(windDirection, 236, 257.5)) sector = 9;
    if (belongToInterval(windDirection, 257.5, 282.5)) sector = 10;
    if (belongToInterval(windDirection, 282.5, 304)) sector = 11;
    if (belongToInterval(windDirection, 304, 333.5)) sector = 12;

    Map map = Map();
    map["u"] = -1;
    map["ur"] = -1;
    map["r"] = -1;
    map["dr"] = -1;
    map["d"] = -1;
    map["dl"] = -1;
    map["l"] = -1;
    map["ul"] = -1;

    if (currentTarget > 5)
      map["d"] = 0;
    else
      map["u"] = 0;
    if (currentTarget == 0 || currentTarget == 6) map["l"] = 0;
    if (currentTarget == 5 || currentTarget == 11) map["r"] = 0;
    if (currentTarget == 0) map["ul"] = 0;
    if (currentTarget == 5) map["ur"] = 0;
    if (currentTarget == 6) map["dl"] = 0;
    if (currentTarget == 11) map["dr"] = 0;

    for (var item in map.entries) {
      if (item.value == -1) {
        if (item.key == "u") map["u"] = WorldState.boxPlaces[currentTarget - 6];
        if (item.key == "d") map["d"] = WorldState.boxPlaces[currentTarget + 6];
        if (item.key == "l") map["l"] = WorldState.boxPlaces[currentTarget - 1];
        if (item.key == "r") map["r"] = WorldState.boxPlaces[currentTarget + 1];
        if (item.key == "ur")
          map["ur"] = WorldState.boxPlaces[currentTarget - 5];
        if (item.key == "dr")
          map["dr"] = WorldState.boxPlaces[currentTarget + 7];
        if (item.key == "dl")
          map["dl"] = WorldState.boxPlaces[currentTarget + 5];
        if (item.key == "ul")
          map["ul"] = WorldState.boxPlaces[currentTarget - 7];
      }
    }

    switch (sector) {
      case 1:
        if (WorldState.shipZ + map["u"] * ContainerBoxDimensions.height <=
            WorldState.ropeEndZ + ContainerBoxDimensions.height) {
          WorldState.windDirection = 0;
          WorldState.windSpeed = 0;
        }
        break;
      case 2:
        if ((WorldState.shipZ + map["ur"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["u"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          WorldState.windDirection = 0;
          WorldState.windSpeed = 0;
        }
        break;
      case 3:
        if ((WorldState.shipZ + map["ur"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["r"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          WorldState.windDirection = 0;
          WorldState.windSpeed = 0;
        }
        break;
      case 4:
        if (WorldState.shipZ + map["r"] * ContainerBoxDimensions.height <=
            WorldState.ropeEndZ + ContainerBoxDimensions.height) {
          WorldState.windDirection = 0;
          WorldState.windSpeed = 0;
        }
        break;
      case 5:
        if ((WorldState.shipZ + map["r"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["dr"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          WorldState.windDirection = 0;
          WorldState.windSpeed = 0;
        }
        break;
      case 6:
        if ((WorldState.shipZ + map["dr"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["d"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          WorldState.windDirection = 0;
          WorldState.windSpeed = 0;
        }
        break;
      case 7:
        if (WorldState.shipZ + map["d"] * ContainerBoxDimensions.height <=
            WorldState.ropeEndZ + ContainerBoxDimensions.height) {
          WorldState.windDirection = 0;
          WorldState.windSpeed = 0;
        }
        break;
      case 8:
        if ((WorldState.shipZ + map["dl"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["d"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          WorldState.windDirection = 0;
          WorldState.windSpeed = 0;
        }
        break;
      case 9:
        if ((WorldState.shipZ + map["dl"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["l"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          WorldState.windDirection = 0;
          WorldState.windSpeed = 0;
        }
        break;
      case 10:
        if (WorldState.shipZ + map["l"] * ContainerBoxDimensions.height <=
            WorldState.ropeEndZ + ContainerBoxDimensions.height) {
          WorldState.windDirection = 0;
          WorldState.windSpeed = 0;
        }
        break;
      case 11:
        if ((WorldState.shipZ + map["l"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["ul"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          WorldState.windDirection = 0;
          WorldState.windSpeed = 0;
        }
        break;
      case 12:
        if ((WorldState.shipZ + map["ul"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["u"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          WorldState.windDirection = 0;
          WorldState.windSpeed = 0;
        }
        break;
      default:
    }

    containerMovement();
  }
}
