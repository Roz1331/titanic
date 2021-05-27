import 'package:flutter/material.dart';
import '../responsive_size.dart';

class WaveSettings extends StatefulWidget {
  @override
  _WaveSettingsState createState() => _WaveSettingsState();
}

class _WaveSettingsState extends State<WaveSettings> {
  int selectedRadioTile;
  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
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
            value: 1,
            groupValue: selectedRadioTile,
            onChanged: setSelectedRadioTile,
            title: Text("1 функция"),
          ),
          RadioListTile(
            activeColor: Color(0xFF000060),
            value: 2,
            groupValue: selectedRadioTile,
            onChanged: setSelectedRadioTile,
            title: Text("2 функция"),
          ),
          RadioListTile(
            activeColor: Color(0xFF000060),
            value: 3,
            groupValue: selectedRadioTile,
            onChanged: setSelectedRadioTile,
            title: Text("3 функция"),
          ),
        ],
      ),
    );
  }
}
