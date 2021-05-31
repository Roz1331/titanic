import 'dart:math';

import 'package:calculess/calculess.dart';
import 'package:tower_crane/logic/common_point.dart';
import 'package:tower_crane/physics/physics.dart';
import 'package:tower_crane/stupid_constants.dart';
import 'package:tower_crane/world_state.dart';
import 'package:tower_crane/logic/logicZDown.dart';

class LogicZUp {
  static double _getProbability(
      double dist, double x1, double y1, double x2, double y2) {
    return (dist * (y2 - y1) - x1 * y2 + y1 * x2) / (x2 - x1);
  }

  static double _getXFromEquation(
      double y, double x1, double y1, double x2, double y2) {
    return (y * (x2 - x1) - y1 * x2 + x1 * y2) / (y2 - y1);
  }
  static void containerUpVelocity() {
    double differenceSpeed = WorldState.oldSpeed - WorldState.windSpeed;
    if(differenceSpeed > 0)
    {
      List<String> windDistanceList = [];
      if (belongToInterval(differenceSpeed, 0, 10)) {
        windDistanceList.add("verySmall");
      }

      if (belongToInterval(differenceSpeed, 5, 20)) {
        windDistanceList.add("small");
      }
      if (belongToInterval(differenceSpeed, 15, 35)) {
        windDistanceList.add("medium");
      }
      if (differenceSpeed >= 50) windDistanceList.add("big");
      List<double> getIntersectionCoordinates = [
      ]; //координаты пересечения прямых
      List<double> probabilities = [];
      if (windDistanceList.length == 2) {
        if (windDistanceList[0] == "verySmall") {
          getIntersectionCoordinates.add(5);
          getIntersectionCoordinates.add(10);
        } else if (windDistanceList[0] == "small") {
          getIntersectionCoordinates.add(15);
          getIntersectionCoordinates.add(20);
        } else if (windDistanceList[0] == "medium") {
          getIntersectionCoordinates.add(25);
          getIntersectionCoordinates.add(35);
        }

        probabilities.add(_getProbability(differenceSpeed,
            getIntersectionCoordinates[0], 0, getIntersectionCoordinates[1],
            1));
        probabilities.add(_getProbability(differenceSpeed,
            getIntersectionCoordinates[0], 1, getIntersectionCoordinates[1],
            0));
      } else
        probabilities.add(1);
      Map<String, List<String>> rules = {};
      rules["big"] = ["veryFastV", "fastV"];
      rules["medium"] = ["averageV"];
      rules["small"] = ["slowV"];
      rules["verySmall"] = ["stopV"];
      Map<String, double> velocityProbability = {};
      for (int i = 0; i < windDistanceList.length; i++) {
        for (int j = 0; j < rules[windDistanceList[i]].length; j++) {
          velocityProbability[rules[windDistanceList[i]][j]] =
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
        if (key == "slowV") {
          velocityList.add(0);
          velocityList.add(0.3);
          velocityList.add(0.5);
          velocityList.add(0.7);
        }
        if (key == "averageV") {
          velocityList.add(0.5);
          velocityList.add(0.7);
          velocityList.add(1.5);
          velocityList.add(2);
        }
        if (key == "fastV") {
          velocityList.add(1.5);
          velocityList.add(2);
          velocityList.add(6);
          velocityList.add(10);
        }
        if (key == "veryFastV") {
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
        if (coordinates[1] != coordinates[0]) {
          numerator += Calc.integral(
              coordinates[0],
              coordinates[1],
                  (x) =>
              x *
                  (x * (1 - 0) - coordinates[0] * 1 + 0 * coordinates[1]) /
                  (coordinates[1] - coordinates[0]),
              10);
        }
        if (coordinates[1] != coordinates[2]) {
          numerator += Calc.integral(
              coordinates[1],
              coordinates[2],
                  (x) =>
              x *
                  (x * (1 - 1) - coordinates[1] * 1 + 1 * coordinates[2]) /
                  (coordinates[2] - coordinates[1]),
              10);
        }
        if (coordinates[3] != coordinates[2]) {
          numerator += Calc.integral(
              coordinates[2],
              coordinates[3],
                  (x) =>
              x *
                  (x * (0 - 1) - coordinates[2] * 0 + 1 * coordinates[3]) /
                  (coordinates[3] - coordinates[2]),
              10);
        }
        double denominator = 0;
        if (coordinates[0] != coordinates[1]) {
          denominator += Calc.integral(
              coordinates[0],
              coordinates[1],
                  (x) =>
              (x * (1 - 0) - coordinates[0] * 1 + 0 * coordinates[1]) /
                  (coordinates[1] - coordinates[0]),
              10);
        }
        if (coordinates[1] != coordinates[2]) {
          denominator += Calc.integral(
              coordinates[1],
              coordinates[2],
                  (x) =>
              (x * (1 - 1) - coordinates[1] * 1 + 1 * coordinates[2]) /
                  (coordinates[2] - coordinates[1]),
              10);
        }
        if (coordinates[2] != coordinates[3]) {
          denominator += Calc.integral(
              coordinates[2],
              coordinates[3],
                  (x) =>
              (x * (0 - 1) - coordinates[2] * 0 + 1 * coordinates[3]) /
                  (coordinates[3] - coordinates[2]),
              10);
        }
        WorldState.containerUpVelocity = numerator / denominator;
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
              probabilities2[0], finalCoordinates[0], 0, finalCoordinates[1],
              1);
          if (finalCoordinates[1] != finalCoordinates[0]) {
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
          }

          double max2 = _getXFromEquation(
              probabilities2[0], finalCoordinates[2], 1, finalCoordinates[3],
              0);
          numerator +=
              Calc.integral(max, max2, (x) => x * probabilities2[0], 10);
          if (finalCoordinates[3] != finalCoordinates[2]) {
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
          }

          double max3 = _getXFromEquation(
              probabilities2[1], finalCoordinates[2], 0, finalCoordinates[3],
              1);
          if (finalCoordinates[3] != finalCoordinates[2]) {
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
          }

          double max4 = _getXFromEquation(
              probabilities2[1], finalCoordinates[4], 1, finalCoordinates[5],
              0);
          numerator +=
              Calc.integral(max3, max4, (x) => x * probabilities2[1], 10);
          if (finalCoordinates[5] != finalCoordinates[4]) {
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
          }
          if (finalCoordinates[0] != finalCoordinates[1]) {
            denominator += Calc.integral(
                finalCoordinates[0],
                max,
                    (x) =>
                (x * (1 - 0) -
                    finalCoordinates[0] * 1 +
                    0 * finalCoordinates[1]) /
                    (finalCoordinates[1] - finalCoordinates[0]),
                10);
          }

          denominator += Calc.integral(max, max2, (x) => probabilities2[0], 10);
          if (finalCoordinates[2] != finalCoordinates[3]) {
            denominator += Calc.integral(
                max2,
                commonPoint.x,
                    (x) =>
                (x * (0 - 1) -
                    finalCoordinates[2] * 0 +
                    1 * finalCoordinates[3]) /
                    (finalCoordinates[3] - finalCoordinates[2]),
                10);
          }
          if (finalCoordinates[3] != finalCoordinates[2]) {
            denominator += Calc.integral(
                commonPoint.x,
                max3,
                    (x) =>
                (x * (1 - 0) -
                    finalCoordinates[2] * 1 +
                    0 * finalCoordinates[3]) /
                    (finalCoordinates[3] - finalCoordinates[2]),
                10);
          }

          denominator +=
              Calc.integral(max3, max4, (x) => probabilities2[1], 10);
          if (finalCoordinates[4] != finalCoordinates[5]) {
            denominator += Calc.integral(
                max4,
                finalCoordinates[5],
                    (x) =>
                (x * (0 - 1) -
                    finalCoordinates[4] * 0 +
                    1 * finalCoordinates[5]) /
                    (finalCoordinates[5] - finalCoordinates[4]),
                10);
          }
          print("3  $denominator");
          WorldState.containerUpVelocity = numerator / denominator;
        } else if (probabilities2[0] == probabilities2[1] &&
            probabilities2[0] == commonPoint.y) {
          double max = _getXFromEquation(
              probabilities2[0], finalCoordinates[0], 0, finalCoordinates[1],
              1);
          if (finalCoordinates[1] != finalCoordinates[0]) {
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
          }
          double max4 = _getXFromEquation(
              probabilities2[1], finalCoordinates[4], 1, finalCoordinates[5],
              0);

          numerator += Calc.integral(max, max4, (x) => x * commonPoint.y, 10);
          if (finalCoordinates[5] != finalCoordinates[4]) {
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
          }

          if (finalCoordinates[1] != finalCoordinates[0]) {
            denominator += Calc.integral(
                finalCoordinates[0],
                max,
                    (x) =>
                (x * (1 - 0) -
                    finalCoordinates[0] * 1 +
                    0 * finalCoordinates[1]) /
                    (finalCoordinates[1] - finalCoordinates[0]),
                10);
          }

          denominator += Calc.integral(max, max4, (x) => commonPoint.y, 10);
          if (finalCoordinates[4] != finalCoordinates[5]) {
            denominator += Calc.integral(
                max4,
                finalCoordinates[5],
                    (x) =>
                (x * (0 - 1) -
                    finalCoordinates[4] * 0 +
                    1 * finalCoordinates[5]) /
                    (finalCoordinates[5] - finalCoordinates[4]),
                10);
          }

          WorldState.containerUpVelocity = numerator / denominator;
        } else {
          double max = _getXFromEquation(
              probabilities2[0], finalCoordinates[0], 0, finalCoordinates[1],
              1);
          if (finalCoordinates[1] != finalCoordinates[0]) {
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
          }

          double max2 = 0,
              max3 = 0;
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
          numerator +=
              Calc.integral(max, max2, (x) => x * probabilities2[0], 10);
          if (max3 != max2) {
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
          }
          double max4 = _getXFromEquation(
              probabilities2[1], finalCoordinates[4], 1, finalCoordinates[5],
              0);
          numerator +=
              Calc.integral(max3, max4, (x) => x * probabilities2[1], 10);
          if (finalCoordinates[5] != finalCoordinates[4]) {
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
          }

          if (finalCoordinates[1] != finalCoordinates[0]) {
            denominator += Calc.integral(
                finalCoordinates[0],
                max,
                    (x) =>
                (x * (1 - 0) -
                    finalCoordinates[0] * 1 +
                    0 * finalCoordinates[1]) /
                    (finalCoordinates[1] - finalCoordinates[0]),
                10);
          }

          denominator += Calc.integral(max, max2, (x) => probabilities2[0], 10);

          if (max3 != max2) {
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
          }
          denominator +=
              Calc.integral(max3, max4, (x) => probabilities2[1], 10);

          if (finalCoordinates[5] != finalCoordinates[4]) {
            denominator += Calc.integral(
                max4,
                finalCoordinates[5],
                    (x) =>
                (x * (0 - 1) -
                    finalCoordinates[4] * 0 +
                    1 * finalCoordinates[5]) /
                    (finalCoordinates[5] - finalCoordinates[4]),
                10);
          }

          WorldState.containerUpVelocity = numerator / denominator;
        }
      }
      print(WorldState.containerUpVelocity);
    }
  }
}
