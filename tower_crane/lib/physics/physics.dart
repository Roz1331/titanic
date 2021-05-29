import 'dart:math';

import 'package:tower_crane/physics/point2d.dart';
import 'package:tower_crane/world_state.dart';

double _radianConverter(double degree) {
  return degree * 180 / pi;
}

bool _belongToInterval(double x, double left, double right) {
  return x >= left && x < right;
}

class Physics {
  static int marginTop = 30;

  //вернет лист точек конца веревки
  static List<Point2d> containerMovement() {
    double zCoordTemp =
        WorldState.ropeLength * cos(_radianConverter(WorldState.windSpeed));
    double zCoordinate = marginTop + zCoordTemp;

    double xCoordTemp = WorldState.ropeLength *
        sin(_radianConverter(WorldState.windSpeed)); // радиус окружности
    double xCoordTemp2 = xCoordTemp *
        sin(_radianConverter(WorldState.windDirection)); // смещение по Х
    double xCoordinate = WorldState.shipX + xCoordTemp2;
    Point2d xzPoint = new Point2d(xCoordinate, zCoordinate);

    double yCoordTemp = xCoordTemp; // радиус окружности
    double yCoordTemp2 = yCoordTemp *
        cos(_radianConverter(WorldState.windDirection)); // смещение по Y
    double yCoordinate = WorldState.shipY + yCoordTemp2;
    Point2d xyPoint = new Point2d(xCoordinate, yCoordinate);

    return []..add(xzPoint)..add(xyPoint);
  }

  //обнуляет ветер при достижении контейнера
  static List<Point2d> containerMovementWithBlocks() {
    double windDirection = WorldState.windDirection;
    double windSpeed = WorldState.windSpeed;
    int currentTarget = WorldState.currentTarget;

    // if (_belongToInterval(windDirection, 0, 26.5) ||
    //     _belongToInterval(windDirection, 333.5, 360)) {
    //   if (currentTarget > 6 &&
    //       (WorldState.boxPlaces[currentTarget - 7] >
    //           WorldState.boxPlaces[currentTarget]))
    //     WorldState.windDirection = 0;
    // } else if (_belongToInterval(windDirection, 26.5, 56)) {
    //   if (currentTarget > 6 &&
    //       (WorldState.boxPlaces[currentTarget - 7] >
    //               WorldState.boxPlaces[currentTarget] ||
    //           (currentTarget != 13 &&
    //               WorldState.boxPlaces[currentTarget - 6] >
    //                   WorldState.boxPlaces[currentTarget])))
    //     WorldState.windDirection = 0;
    // }

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
        if (map["u"] > WorldState.boxPlaces[currentTarget]) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 2:
        if (map["ur"] > WorldState.boxPlaces[currentTarget] ||
            map["u"] > WorldState.boxPlaces[currentTarget]) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 3:
        if (map["ur"] > WorldState.boxPlaces[currentTarget] ||
            map["r"] > WorldState.boxPlaces[currentTarget]) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 4:
        if (map["r"] > WorldState.boxPlaces[currentTarget]) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 5:
        if (map["r"] > WorldState.boxPlaces[currentTarget] ||
            map["dr"] > WorldState.boxPlaces[currentTarget]) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 6:
        if (map["dr"] > WorldState.boxPlaces[currentTarget] ||
            map["d"] > WorldState.boxPlaces[currentTarget]) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 7:
        if (map["d"] > WorldState.boxPlaces[currentTarget]) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 8:
        if (map["dl"] > WorldState.boxPlaces[currentTarget] ||
            map["d"] > WorldState.boxPlaces[currentTarget]) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 9:
        if (map["dl"] > WorldState.boxPlaces[currentTarget] ||
            map["l"] > WorldState.boxPlaces[currentTarget]) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 10:
        if (map["l"] > WorldState.boxPlaces[currentTarget]) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 11:
        if (map["l"] > WorldState.boxPlaces[currentTarget] ||
            map["ul"] > WorldState.boxPlaces[currentTarget]) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      case 12:
        if (map["ul"] > WorldState.boxPlaces[currentTarget] ||
            map["u"] > WorldState.boxPlaces[currentTarget]) {
          windDirection = 0;
          windSpeed = 0;
        }
        break;
      default:
    }

    //containerMovement();

    return [];
  }
}
