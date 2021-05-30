import 'package:flutter/material.dart';
import '../../physics/physics.dart';
import '../../world_state.dart';
import '../responsive_size.dart';

class WindSettings extends StatefulWidget {
  @override
  _WindSettingsState createState() => _WindSettingsState();
}

class _WindSettingsState extends State<WindSettings> {
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
      height: 200.h,
      width: 283.w,
      child: Column(
        children: [
          Text(
            "Направление",
            style: TextStyle(
              fontSize: 14.h,
            ),
          ),
          Container(
            height: 40.h,
            child: Slider(
              divisions: 360,
              label: WorldState.windDirection.toInt().toString(),
              activeColor: Color(0xFF000060),
              min: 0,
              max: 359,
              value: WorldState.windDirection,
              onChanged: (value) {
                setState(() {
                  WorldState.windDirection = value;
                });
              },
            ),
          ),
          Spacer(
            flex: 5,
          ),
          Text(
            "Скорость",
            style: TextStyle(
              fontSize: 14.h,
            ),
          ),
          Container(
            height: 40.h,
            child: Slider(
              divisions: 46,
              label: WorldState.windSpeed.toInt().toString(),
              activeColor: Color(0xFF000060),
              min: 0,
              max: 45,
              value: WorldState.windSpeed,
              onChanged: (value) {
                setState(() {
                  WorldState.windSpeed = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
