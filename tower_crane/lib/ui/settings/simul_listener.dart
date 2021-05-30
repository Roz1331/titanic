import 'dart:async';

class SimulationListener {
  static final StreamController streamController =
      StreamController<bool>.broadcast();

  static final Stream simulationStream = streamController.stream;
}