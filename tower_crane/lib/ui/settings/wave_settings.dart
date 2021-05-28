import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tower_crane/ui/painters_layout/ship_side_painter.dart';
import '../../stupid_constants.dart';
import '../responsive_size.dart';

class WaveSettings extends StatefulWidget {
  @override
  _WaveSettingsState createState() => _WaveSettingsState();
}

class _WaveSettingsState extends State<WaveSettings> {
  Timer timer;
  int selectedTile = 1;

  setSelectedRadioTile(dynamic val) {
    setState(() {
      switch(val){
        case 1: StaticFun.waveFunction = (double x) => sin(x); break;
        case 2: StaticFun.waveFunction = (double x) => sin(8*x); break;
        case 3: StaticFun.waveFunction = (double x) => sin(x/2); break;
      }
      selectedTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.height,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 2,
        ),
      ),
      height: 230.height,
      width: 283.width,
      child: Column(
        children: [
          RadioListTile(
            selected: true,
            activeColor: Color(0xFF000060),
            value: 1,
            groupValue: selectedTile,
            onChanged: setSelectedRadioTile,
            title: Text("sin(x)"),
          ),
          RadioListTile(
            activeColor: Color(0xFF000060),
            value: 2,
            groupValue: selectedTile,
            onChanged: setSelectedRadioTile,
            title: Text("2*sin(x)"),
          ),
          RadioListTile(
            activeColor: Color(0xFF000060),
            value: 3,
            groupValue: selectedTile,
            onChanged: setSelectedRadioTile,
            title: Text("sin(x)/2"),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}