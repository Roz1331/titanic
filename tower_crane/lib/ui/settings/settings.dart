import 'package:flutter/material.dart';
import 'package:tower_crane/ui/settings/music_button.dart';
import 'package:tower_crane/ui/settings/start_simulation_button.dart';
import 'package:tower_crane/ui/settings/wave_settings.dart';
import 'package:tower_crane/ui/settings/wind_settings.dart';
import '../responsive_size.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 79.h,
      ),
      width: 364.w,
      child: Column(
        children: [
          WindSettings(),
          SizedBox(
            height: 30.h,
          ),
          WaveSettings(),
          SizedBox(
            height: 30.h,
          ),
          StartSimulationButton(),
          SizedBox(
            height: 30.h,
          ),
          MusicButton(),
        ],
      ),
    );
  }
}
