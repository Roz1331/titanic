import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tower_crane/ui/settings/simul_listener.dart';
import 'package:tower_crane/world_state.dart';
import '../responsive_size.dart';

class StartSimulationButton extends StatefulWidget {
  @override
  _StartSimulationButtonState createState() => _StartSimulationButtonState();
}

class _StartSimulationButtonState extends State<StartSimulationButton> {
  StreamSubscription streamSubscription;
  bool isSimulated = WorldState.isSimulated;

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    streamSubscription = SimulationListener.simulationStream.listen((event) {
      setState(() {
        isSimulated = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          Size(283.w, 80.h),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          WorldState.isSimulated
              ? Theme.of(context).disabledColor
              : Color(0xFF000060),
        ),
      ),
      onPressed: isSimulated ? null : WorldState.startSimulation,
      icon: Icon(
        Icons.play_arrow_rounded,
        color: Colors.green,
        size: 50,
      ),
      label: Text(
        "НАЧАТЬ",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }
}
