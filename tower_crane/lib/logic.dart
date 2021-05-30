import 'package:tower_crane/world_state.dart';
import 'package:tower_crane/stupid_constants.dart';
import 'dart:math';

class Logic {
  static void carriageTDownVelocity(Function operand) {
    double carriageToShipDistance = WorldState.shipZ -
        WorldState.boxPlaces[WorldState.currentTarget] *
            ContainerBoxDimensions.height -
        WorldState.containerBoxZ;
    double time = 0;

    while (carriageToShipDistance >= 1) {
      time += 0.1;
    }
  }
}
