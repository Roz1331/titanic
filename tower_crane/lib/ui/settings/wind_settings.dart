import 'package:flutter/material.dart';
import '../responsive_size.dart';

class WindSettings extends StatefulWidget {
  @override
  _WindSettingsState createState() => _WindSettingsState();
}

class _WindSettingsState extends State<WindSettings> {
  double directionValue = 0;
  double speedValue = 0;
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
          Text(
            "Направление",
            style: TextStyle(
              fontSize: 14.height,
            ),
          ),
          Slider(
            divisions: 360,
            label: directionValue.toInt().toString(),
            activeColor: Color(0xFF000060),
            min: 0,
            max: 359,
            value: directionValue,
            onChanged: (value) {
              setState(() {
                directionValue = value;
              });
            },
          ),
          Spacer(
            flex: 5,
          ),
          Text(
            "Скорость",
            style: TextStyle(
              fontSize: 14.height,
            ),
          ),
          Slider(
            divisions: 46,
            label: speedValue.toInt().toString(),
            activeColor: Color(0xFF000060),
            min: 0,
            max: 45,
            value: speedValue,
            onChanged: (value) {
              setState(() {
                speedValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
