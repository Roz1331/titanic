import 'dart:async';

import 'package:flutter/material.dart';

import '../../stupid_constants.dart';
import '../../world_state.dart';
import '../responsive_size.dart';

class WaveSettings extends StatefulWidget {
  @override
  _WaveSettingsState createState() => _WaveSettingsState();
}

class _WaveSettingsState extends State<WaveSettings> {
  int selectedTile = 0;

  setSelectedRadioTile(dynamic val) {
    setState(() {
      WorldState.waveFunction = WaveFunctionsHelper.functions[val];
      selectedTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      width: 283.w,
      child: Column(
        children: [
          RadioListTile(
            //selected: true,
            activeColor: Color(0xFF000060),
            value: 0,
            groupValue: selectedTile,
            onChanged: setSelectedRadioTile,
            title: Text(WaveFunctionsHelper.functionStrings[0]),
          ),
          RadioListTile(
            activeColor: Color(0xFF000060),
            value: 1,
            groupValue: selectedTile,
            onChanged: setSelectedRadioTile,
            title: Text(WaveFunctionsHelper.functionStrings[1]),
          ),
          RadioListTile(
            activeColor: Color(0xFF000060),
            value: 2,
            groupValue: selectedTile,
            onChanged: setSelectedRadioTile,
            title: Text(WaveFunctionsHelper.functionStrings[2]),
          ),
        ],
      ),
    );
  }
}
