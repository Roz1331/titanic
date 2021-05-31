import 'dart:math';

import 'package:calculess/calculess.dart';
import 'package:tower_crane/common_point.dart';
import 'package:tower_crane/physics/physics.dart';
import 'package:tower_crane/stupid_constants.dart';
import 'package:tower_crane/world_state.dart';

class Logic {
  static double _getProbability(
      double dist, double x1, double y1, double x2, double y2) {
    return (dist * (y2 - y1) - x1 * y2 + y1 * x2) / (x2 - x1);
  }

  static double _getXFromEquation(
      double y, double x1, double y1, double x2, double y2) {
    return (y * (x2 - x1) - y1 * x2 + x1 * y2) / (y2 - y1);
  }

  static void containerDownVelocity() {
    double containerToShipDistance = WorldState.shipZ -
        WorldState.boxPlaces[WorldState.currentTarget] *
            ContainerBoxDimensions.height -
        WorldState.containerBoxZ;
    WorldState.containerToShipDistance = containerToShipDistance;
    List<String> containerToShipDistanceList = [];
    if (belongToInterval(containerToShipDistance, 0, 5)){
      containerToShipDistanceList.add("veryClose");
    }

    if (belongToInterval(containerToShipDistance, 1, 30)) {
      containerToShipDistanceList.add("close");
    }
    if (belongToInterval(containerToShipDistance, 25, 70)) {
      containerToShipDistanceList.add("medium");
    }
    if (containerToShipDistance >= 50) containerToShipDistanceList.add("far");
    List<double> getIntersectionCoordinates = [];
    List<double> probabilities = [];
    if (containerToShipDistanceList.length == 2) {
      if (containerToShipDistanceList[0] == "veryClose") {
        getIntersectionCoordinates.add(1);
        getIntersectionCoordinates.add(5);
      } else if (containerToShipDistanceList[0] == "close") {
        getIntersectionCoordinates.add(25);
        getIntersectionCoordinates.add(30);
      } else if (containerToShipDistanceList[0] == "medium") {
        getIntersectionCoordinates.add(50);
        getIntersectionCoordinates.add(70);
      }

      probabilities.add(_getProbability(containerToShipDistance,
          getIntersectionCoordinates[0], 0, getIntersectionCoordinates[1], 1));
      probabilities.add(_getProbability(containerToShipDistance,
          getIntersectionCoordinates[0], 1, getIntersectionCoordinates[1], 0));
    } else
      probabilities.add(1);
    Map<String, List<String>> rules = {};
    rules["far"] = ["fastV", "mediumV"];
    rules["medium"] = ["slowV"];
    rules["close"] = ["verySlowV"];
    rules["veryClose"] = ["stopV"];
    Map<String, double> velocityProbability = {};
    for (int i = 0; i < containerToShipDistanceList.length; i++) {
      for (int j = 0; j < rules[containerToShipDistanceList[i]].length; j++) {
        velocityProbability[rules[containerToShipDistanceList[i]][j]] =
            probabilities[i];
      }
    }
    Map<String, List<double>> velocityMap = {};
    velocityProbability.forEach((key, value) {
      List<double> velocityList = [];
      if (key == "stopV") {
        velocityList.add(0);
        velocityList.add(0);
        velocityList.add(0);
        velocityList.add(0.3);
      }
      if (key == "verySlowV") {
        velocityList.add(0);
        velocityList.add(0.3);
        velocityList.add(0.5);
        velocityList.add(0.7);
      }
      if (key == "slowV") {
        velocityList.add(0.5);
        velocityList.add(0.7);
        velocityList.add(1.5);
        velocityList.add(2);
      }
      if (key == "mediumV") {
        velocityList.add(1.5);
        velocityList.add(2);
        velocityList.add(6);
        velocityList.add(10);
      }
      if (key == "fastV") {
        velocityList.add(6);
        velocityList.add(10);
        velocityList.add(20);
        velocityList.add(20);
      }
      velocityMap[key] = velocityList;
    });

    if (velocityProbability.length == 1) {
      List<double> coordinates = [];
      velocityProbability.forEach((key, value) {
        coordinates = velocityMap[key];
      });

      double numerator = 0;
      numerator += Calc.integral(
          coordinates[0],
          coordinates[1],
          (x) =>
              x *
              (x * (1 - 0) - coordinates[0] * 1 + 0 * coordinates[1]) /
              (coordinates[1] - coordinates[0]),
          10);
      numerator += Calc.integral(
          coordinates[1],
          coordinates[2],
          (x) =>
              x *
              (x * (1 - 1) - coordinates[1] * 1 + 1 * coordinates[2]) /
              (coordinates[2] - coordinates[1]),
          10);
      numerator += Calc.integral(
          coordinates[2],
          coordinates[3],
          (x) =>
              x *
              (x * (0 - 1) - coordinates[2] * 0 + 1 * coordinates[3]) /
              (coordinates[3] - coordinates[2]),
          10);
      double denominator = 0;
      denominator += Calc.integral(
          coordinates[0],
          coordinates[1],
          (x) =>
              (x * (1 - 0) - coordinates[0] * 1 + 0 * coordinates[1]) /
              (coordinates[1] - coordinates[0]),
          10);
      denominator += Calc.integral(
          coordinates[1],
          coordinates[2],
          (x) =>
              (x * (1 - 1) - coordinates[1] * 1 + 1 * coordinates[2]) /
              (coordinates[2] - coordinates[1]),
          10);
      denominator += Calc.integral(
          coordinates[2],
          coordinates[3],
          (x) =>
              (x * (0 - 1) - coordinates[2] * 0 + 1 * coordinates[3]) /
              (coordinates[3] - coordinates[2]),
          10);
      print("2 $denominator");
      WorldState.containerDownVelocity = numerator / denominator;
    } else {
      List<List<double>> coordinates = [];
      List<double> probabilities2 = [];
      velocityProbability.forEach((key, value) {
        coordinates.add(velocityMap[key]);
        probabilities2.add(value);
      });
      List<double> finalCoordinates = [];
      finalCoordinates.add(coordinates[0][0]);
      finalCoordinates.add(coordinates[0][1]);
      finalCoordinates.add(coordinates[0][2]);
      finalCoordinates.add(coordinates[0][3]);
      finalCoordinates.add(coordinates[1][2]);
      finalCoordinates.add(coordinates[1][3]);

      MyPoint commonPoint = CommonPoint.findCommonPoint(
        firstEquation: LinearEquation(
            MyPoint(finalCoordinates[2], 0), MyPoint(finalCoordinates[3], 1)),
        secondEquation: LinearEquation(
            MyPoint(finalCoordinates[2], 1), MyPoint(finalCoordinates[3], 0)),
      );
      double numerator = 0;
      double denominator = 0;
      if (probabilities2[0] > commonPoint.y &&
          probabilities2[1] > commonPoint.y) {
        double max = _getXFromEquation(
            probabilities2[0], finalCoordinates[0], 0, finalCoordinates[1], 1);
        numerator += Calc.integral(
            finalCoordinates[0],
            max,
            (x) =>
                x *
                ((x * (1 - 0) -
                        finalCoordinates[0] * 1 +
                        0 * finalCoordinates[1]) /
                    (finalCoordinates[1] - finalCoordinates[0])),
            10);

        double max2 = _getXFromEquation(
            probabilities2[0], finalCoordinates[2], 1, finalCoordinates[3], 0);
        numerator += Calc.integral(max, max2, (x) => x * probabilities2[0], 10);

        numerator += Calc.integral(
            max2,
            commonPoint.x,
            (x) =>
                x *
                ((x * (0 - 1) -
                        finalCoordinates[2] * 0 +
                        1 * finalCoordinates[3]) /
                    (finalCoordinates[3] - finalCoordinates[2])),
            10);

        double max3 = _getXFromEquation(
            probabilities2[1], finalCoordinates[2], 0, finalCoordinates[3], 1);
        numerator += Calc.integral(
            commonPoint.x,
            max3,
            (x) =>
                x *
                ((x * (1 - 0) -
                        finalCoordinates[2] * 1 +
                        0 * finalCoordinates[3]) /
                    (finalCoordinates[3] - finalCoordinates[2])),
            10);

        double max4 = _getXFromEquation(
            probabilities2[1], finalCoordinates[4], 1, finalCoordinates[5], 0);
        numerator +=
            Calc.integral(max3, max4, (x) => x * probabilities2[1], 10);
        numerator += Calc.integral(
            max4,
            finalCoordinates[5],
            (x) =>
                x *
                ((x * (0 - 1) -
                        finalCoordinates[4] * 0 +
                        1 * finalCoordinates[5]) /
                    (finalCoordinates[5] - finalCoordinates[4])),
            10);

        denominator += Calc.integral(
            finalCoordinates[0],
            max,
            (x) =>
                (x * (1 - 0) -
                    finalCoordinates[0] * 1 +
                    0 * finalCoordinates[1]) /
                (finalCoordinates[1] - finalCoordinates[0]),
            10);

        denominator += Calc.integral(max, max2, (x) => probabilities2[0], 10);

        denominator += Calc.integral(
            max2,
            commonPoint.x,
            (x) =>
                (x * (0 - 1) -
                    finalCoordinates[2] * 0 +
                    1 * finalCoordinates[3]) /
                (finalCoordinates[3] - finalCoordinates[2]),
            10);

        denominator += Calc.integral(
            commonPoint.x,
            max3,
            (x) =>
                (x * (1 - 0) -
                    finalCoordinates[2] * 1 +
                    0 * finalCoordinates[3]) /
                (finalCoordinates[3] - finalCoordinates[2]),
            10);

        denominator += Calc.integral(max3, max4, (x) => probabilities2[1], 10);
        denominator += Calc.integral(
            max4,
            finalCoordinates[5],
            (x) =>
                (x * (0 - 1) -
                    finalCoordinates[4] * 0 +
                    1 * finalCoordinates[5]) /
                (finalCoordinates[5] - finalCoordinates[4]),
            10);
        print("3  $denominator");
        WorldState.containerDownVelocity = numerator / denominator;
      } else if (probabilities2[0] == probabilities2[1] && probabilities2[0] == commonPoint.y) {
        double max = _getXFromEquation(
            probabilities2[0], finalCoordinates[0], 0, finalCoordinates[1], 1);
        numerator += Calc.integral(
            finalCoordinates[0],
            max,
                (x) =>
            x *
                ((x * (1 - 0) -
                    finalCoordinates[0] * 1 +
                    0 * finalCoordinates[1]) /
                    (finalCoordinates[1] - finalCoordinates[0])),
            10);
        double max4 = _getXFromEquation(
            probabilities2[1], finalCoordinates[4], 1, finalCoordinates[5], 0);

        numerator += Calc.integral(max, max4, (x) => x * commonPoint.y, 10);

        numerator += Calc.integral(
            max4,
            finalCoordinates[5],
                (x) =>
            x *
                ((x * (0 - 1) -
                    finalCoordinates[4] * 0 +
                    1 * finalCoordinates[5]) /
                    (finalCoordinates[5] - finalCoordinates[4])),
            10);


        denominator += Calc.integral(
            finalCoordinates[0],
            max,
                (x) =>
            (x * (1 - 0) -
                    finalCoordinates[0] * 1 +
                    0 * finalCoordinates[1]) /
                    (finalCoordinates[1] - finalCoordinates[0]),
            10);

        denominator += Calc.integral(max, max4, (x) => commonPoint.y, 10);

        denominator += Calc.integral(
            max4,
            finalCoordinates[5],
                (x) =>
            (x * (0 - 1) -
                    finalCoordinates[4] * 0 +
                    1 * finalCoordinates[5]) /
                    (finalCoordinates[5] - finalCoordinates[4]),
            10);

        WorldState.containerDownVelocity = numerator / denominator;
      } else {
        double max = _getXFromEquation(
            probabilities2[0], finalCoordinates[0], 0, finalCoordinates[1], 1);
        numerator += Calc.integral(
            finalCoordinates[0],
            max,
            (x) =>
                x *
                ((x * (1 - 0) -
                        finalCoordinates[0] * 1 +
                        0 * finalCoordinates[1]) /
                    (finalCoordinates[1] - finalCoordinates[0])),
            10);

        double max2 = 0, max3 = 0;
        if (probabilities2[0] > probabilities2[1]) {
          max2 = _getXFromEquation(probabilities2[0], finalCoordinates[2], 1,
              finalCoordinates[3], 0);
          max3 = _getXFromEquation(probabilities2[1], finalCoordinates[2], 1,
              finalCoordinates[3], 0);
        } else {
          max2 = _getXFromEquation(probabilities2[0], finalCoordinates[2], 0,
              finalCoordinates[3], 1);
          max3 = _getXFromEquation(probabilities2[1], finalCoordinates[2], 0,
              finalCoordinates[3], 1);
        }
        numerator += Calc.integral(max, max2, (x) => x * probabilities2[0], 10);
        numerator += Calc.integral(
            max2,
            max3,
            (x) =>
                x *
                ((x * (probabilities2[1] - probabilities2[0]) -
                        max2 * probabilities2[1] +
                        probabilities2[0] * max3) /
                    (max3 - max2)),
            10);
        double max4 = _getXFromEquation(
            probabilities2[1], finalCoordinates[4], 1, finalCoordinates[5], 0);
        numerator +=
            Calc.integral(max3, max4, (x) => x * probabilities2[1], 10);
        numerator += Calc.integral(
            max4,
            finalCoordinates[5],
            (x) =>
                x *
                ((x * (0 - 1) -
                        finalCoordinates[4] * 0 +
                        1 * finalCoordinates[5]) /
                    (finalCoordinates[5] - finalCoordinates[4])),
            10);
        print("4 1 $denominator");
        denominator += Calc.integral(
            finalCoordinates[0],
            max,
            (x) =>
                (x * (1 - 0) -
                    finalCoordinates[0] * 1 +
                    0 * finalCoordinates[1]) /
                (finalCoordinates[1] - finalCoordinates[0]),
            10);
        print("4 2 $denominator");
        denominator += Calc.integral(max, max2, (x) => probabilities2[0], 10);
        print("4 3 $denominator");
        print("$max2 $max3 ${probabilities2[1]} ${probabilities2[0]}");
        var tempp = Calc.integral(
            max2,
            max3,
            (x) =>
                (x * (probabilities2[1] - probabilities2[0]) -
                    max2 * probabilities2[1] +
                    probabilities2[0] * max3) /
                (max3 - max2),
            10);
        denominator += tempp;
            print("4 4 $denominator $tempp");
        denominator += Calc.integral(max3, max4, (x) => probabilities2[1], 10);
        print("4 5 $denominator");
        denominator += Calc.integral(
            max4,
            finalCoordinates[5],
            (x) =>
                (x * (0 - 1) -
                    finalCoordinates[4] * 0 +
                    1 * finalCoordinates[5]) /
                (finalCoordinates[5] - finalCoordinates[4]),
            10);
        print("4 6 $denominator");
        WorldState.containerDownVelocity = numerator / denominator;
      }
    }
  }
}
