import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
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
      width: 270.w,
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
            width: 240.w,
            child: FlutterSlider(
              trackBar: FlutterSliderTrackBar(
                activeTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0xFF000060),
                ),
                inactiveTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              selectByTap: false,
              tooltip: FlutterSliderTooltip(
                textStyle: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                boxStyle: FlutterSliderTooltipBox(
                  decoration: BoxDecoration(
                    color: Color(0xFF000060),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              values: [WorldState.windDirection],
              min: 0,
              max: 359,
              onDragging: (_, value, __) {
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
            width: 240.w,
            child: FlutterSlider(
              trackBar: FlutterSliderTrackBar(
                activeTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0xFF000060),
                ),
                inactiveTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              selectByTap: false,
              tooltip: FlutterSliderTooltip(
                textStyle: TextStyle(fontSize: 17, color: Colors.white),
                boxStyle: FlutterSliderTooltipBox(
                  decoration: BoxDecoration(
                    color: Color(0xFF000060),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              values: [WorldState.windSpeed],
              min: 0,
              max: 45,
              onDragging: (_, value, __) {
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
