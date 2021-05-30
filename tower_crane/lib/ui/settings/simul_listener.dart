import 'dart:async';

class SimulationListener {
  // ignore: close_sinks
  static final StreamController streamController =
      StreamController<bool>.broadcast();

  static final Stream simulationStream = streamController.stream;
}