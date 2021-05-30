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

  //вернет лист точек конца веревки
  static void containerMovement() {
    double zCoordTemp =
        WorldState.ropeLength * cos(_radianConverter(WorldState.windSpeed));
    double zCoordinate = marginTop + zCoordTemp;
    WorldState.ropeEndZ = zCoordinate;

    double xCoordTemp = WorldState.ropeLength *
        sin(_radianConverter(WorldState.windSpeed)); // радиус окружности
    double xCoordTemp2 = xCoordTemp *
        sin(_radianConverter(WorldState.windDirection)); // смещение по Х
    double xCoordinate = WorldState.carriageX + xCoordTemp2;
    WorldState.ropeEndX = xCoordinate;

    double yCoordTemp = xCoordTemp; // радиус окружности
    double yCoordTemp2 = yCoordTemp *
        cos(_radianConverter(WorldState.windDirection)); // смещение по Y
    double yCoordinate = WorldState.carriageY + yCoordTemp2;
    WorldState.ropeEndY = yCoordinate;
  }

  //обнуляет ветер при достижении контейнера
  static void containerMovementWithBlocks() {
    double windDirection = WorldState.windDirection;
    double windSpeed = WorldState.windSpeed;
    int currentTarget = WorldState.currentTarget;

    int sector = 0;

    if (_belongToInterval(windDirection, 0, 26.5) ||
        _belongToInterval(windDirection, 333.5, 360)) sector = 1;
    if (_belongToInterval(windDirection, 26.5, 56)) sector = 2;
    if (_belongToInterval(windDirection, 56, 77.5)) sector = 3;
    if (_belongToInterval(windDirection, 77.5, 102.5)) sector = 4;
    if (_belongToInterval(windDirection, 102.5, 124)) sector = 5;
    if (_belongToInterval(windDirection, 124, 153.5)) sector = 6;
    if (_belongToInterval(windDirection, 153.5, 206.5)) sector = 7;
    if (_belongToInterval(windDirection, 206.5, 236)) sector = 8;
    if (_belongToInterval(windDirection, 236, 257.5)) sector = 9;
    if (_belongToInterval(windDirection, 257.5, 282.5)) sector = 10;
    if (_belongToInterval(windDirection, 282.5, 304)) sector = 11;
    if (_belongToInterval(windDirection, 304, 333.5)) sector = 12;

    Map map = Map();
    map["u"] = -1;
    map["ur"] = -1;
    map["r"] = -1;
    map["dr"] = -1;
    map["d"] = -1;
    map["dl"] = -1;
    map["l"] = -1;
    map["ul"] = -1;

    if (currentTarget > 6)
      map["u"] = 0;
    else
      map["d"] = 0;
    if (currentTarget == 0 || currentTarget == 7) map["l"] = 0;
    if (currentTarget == 6 || currentTarget == 13) map["r"] = 0;

    for (var item in map.entries) {
      if (item.value == -1) {
        if (item.key == "u") map["u"] = WorldState.boxPlaces[currentTarget - 7];
        if (item.key == "d") map["d"] = WorldState.boxPlaces[currentTarget + 7];
        if (item.key == "l") map["l"] = WorldState.boxPlaces[currentTarget - 1];
        if (item.key == "r") map["r"] = WorldState.boxPlaces[currentTarget + 1];
        if (item.key == "ur")
          map["ur"] = WorldState.boxPlaces[currentTarget - 6];
        if (item.key == "dr")
          map["dr"] = WorldState.boxPlaces[currentTarget + 8];
        if (item.key == "dl")
          map["dl"] = WorldState.boxPlaces[currentTarget + 6];
        if (item.key == "ul")
          map["ul"] = WorldState.boxPlaces[currentTarget - 8];
      }
    }

    switch (sector) {
      case 1:
        if (WorldState.shipZ + map["u"] * ContainerBoxDimensions.height <=
            WorldState.ropeEndZ + ContainerBoxDimensions.height) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 2:
        if ((WorldState.shipZ + map["ur"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["u"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 3:
        if ((WorldState.shipZ + map["ur"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["r"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 4:
        if (WorldState.shipZ + map["r"] * ContainerBoxDimensions.height <=
            WorldState.ropeEndZ + ContainerBoxDimensions.height) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 5:
        if ((WorldState.shipZ + map["r"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["dr"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 6:
        if ((WorldState.shipZ + map["dr"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["d"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 7:
        if (WorldState.shipZ + map["d"] * ContainerBoxDimensions.height <=
            WorldState.ropeEndZ + ContainerBoxDimensions.height) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 8:
        if ((WorldState.shipZ + map["dl"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["d"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 9:
        if ((WorldState.shipZ + map["dl"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["l"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 10:
        if (WorldState.shipZ + map["l"] * ContainerBoxDimensions.height <=
            WorldState.ropeEndZ + ContainerBoxDimensions.height) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 11:
        if ((WorldState.shipZ + map["l"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["ul"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 12:
        if ((WorldState.shipZ + map["ul"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height) ||
            (WorldState.shipZ + map["u"] * ContainerBoxDimensions.height <=
                WorldState.ropeEndZ + ContainerBoxDimensions.height)) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      default:
    }

    containerMovement();
  }
}
