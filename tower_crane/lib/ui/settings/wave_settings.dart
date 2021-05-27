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
  @override
  void initState() {
    super.initState();
    StaticFun.waveFunction = (double x) => sin(x);
  }

  setSelectedRadioTile(dynamic val) {
    setState(() {
      StaticFun.waveFunction = val;
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
      height: 200.height,
      width: 283.width,
      child: Column(
        children: [
          RadioListTile(
            activeColor: Color(0xFF000060),
            value: (double x) => sin(x),
            groupValue: StaticFun.waveFunction,
            onChanged: setSelectedRadioTile,
            title: Text("sin(x)"),
          ),
          RadioListTile(
            activeColor: Color(0xFF000060),
            value: (double x) => 2 * sin(x),
            groupValue: StaticFun.waveFunction,
            onChanged: setSelectedRadioTile,
            title: Text("2 функция"),
          ),
          RadioListTile(
            activeColor: Color(0xFF000060),
            value: (double x) => sin(x) / 2,
            groupValue: StaticFun.waveFunction,
            onChanged: setSelectedRadioTile,
            title: Text("3 функция"),
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