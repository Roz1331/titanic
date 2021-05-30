import 'package:tower_crane/world_state.dart';
import 'package:tower_crane/stupid_constants.dart';
import 'package:tower_crane/physics/physics.dart';
import 'dart:math';

class Logic {
  static double _getProbability(double dist, double x1, double y1, double x2, double y2) {
    return (dist * ( y2 - y1) - x1 * y2 + y1 * x2) / (x2 - x1);
  }

  static void containerDownVelocity(Function operand) {

    double containerToShipDistance = WorldState.shipZ -
        WorldState.boxPlaces[WorldState.currentTarget] *
            ContainerBoxDimensions.height -
        WorldState.containerBoxZ;
    WorldState.containerToShipDistance = containerToShipDistance;

    List containerToShipDistanceList = [];
    if (belongToInterval(containerToShipDistance,0,5)) containerToShipDistanceList.add("veryClose");
    if (belongToInterval(containerToShipDistance,1,30)) containerToShipDistanceList.add("close");
    if (belongToInterval(containerToShipDistance,25,70)) containerToShipDistanceList.add("medium");
    if (containerToShipDistance >= 50) containerToShipDistanceList.add("far");

    List getIntersectionCoordinates = [];
    List probabilities = [];
    if(containerToShipDistanceList.length == 2) {
      if(containerToShipDistanceList[0] == "veryClose") {
        getIntersectionCoordinates.add(1);
        getIntersectionCoordinates.add(5);
      } else if(containerToShipDistanceList[0] == "close") {
        getIntersectionCoordinates.add(25);
        getIntersectionCoordinates.add(30);
      } else if(containerToShipDistanceList[0] == "medium") {
        getIntersectionCoordinates.add(50);
        getIntersectionCoordinates.add(70);
      }

      probabilities.add(_getProbability(containerToShipDistance,getIntersectionCoordinates[0], 0, getIntersectionCoordinates[1], 1));
      probabilities.add(_getProbability(containerToShipDistance,getIntersectionCoordinates[0], 1, getIntersectionCoordinates[1], 0));
    }
    else probabilities.add(1);

    Map rules = Map();
    rules["far"] = ["fastV", "mediumV"];
    rules["medium"] = ["slowV"];
    rules["close"] = ["verySlowV"];
    rules["veryClose"] = ["stopV"];

    Map velocityProbability = Map();
    for (int i = 0; i < containerToShipDistanceList.length; i++) {
      for (int j = 0; j < rules[containerToShipDistanceList[i]].length; j++) {
        velocityProbability[rules[containerToShipDistanceList[i]][j]] = probabilities[i];
      }
    }

    List velocityList = [];

    velocityProbability.forEach((key, value) {
      if(key == "stopV") {
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
      }
    });
    



    double time = 0;

    while (containerToShipDistance >= 1) {
      time += 0.1;
    }
  }
}
