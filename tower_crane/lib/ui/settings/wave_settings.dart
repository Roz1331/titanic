import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tower_crane/ui/settings/simul_listener.dart';

import '../../stupid_constants.dart';
import '../../world_state.dart';
import '../responsive_size.dart';

class WaveSettings extends StatefulWidget {
  @override
  _WaveSettingsState createState() => _WaveSettingsState();
}

class _WaveSettingsState extends State<WaveSettings> {
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
  

  int selectedTile = 0;

  setSelectedRadioTile(dynamic val) {
    setState(() {
      WorldState.waveFunction = WaveFunctionsHelper.functions[val];
      selectedTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = 270.w;
    print("Wave " + width.toString());
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 2,
        ),
      ),
      height: 230.h,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 50.h,
            width: 250.w,
            child: RadioListTile(
              activeColor: Color(0xFF000060),
              value: 0,
              groupValue: selectedTile,
              onChanged: isSimulated ? null : setSelectedRadioTile,
              title: Text(WaveFunctionsHelper.functionStrings[0]),
            ),
          ),
          Container(
            height: 50.h,
            width: 250.w,
            child: RadioListTile(
              activeColor: Color(0xFF000060),
              value: 1,
              groupValue: selectedTile,
              onChanged: isSimulated ? null : setSelectedRadioTile,
              title: Text(WaveFunctionsHelper.functionStrings[1]),
            ),
          ),
          Container(
            height: 50.h,
            width: 250.w,
            child: RadioListTile(
              activeColor: Color(0xFF000060),
              value: 2,
              groupValue: selectedTile,
              onChanged: isSimulated ? null : setSelectedRadioTile,
              title: Text(WaveFunctionsHelper.functionStrings[2]),
            ),
          ),
        ],
      ),
    );
  }
}
