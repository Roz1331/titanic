import 'dart:async';

class SimulListener {
  static final StreamController streamController =
      StreamController<bool>.broadcast();

  static final Stream simulationStream = streamController.stream;
}