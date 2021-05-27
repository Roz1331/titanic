import 'package:flutter/material.dart';
import 'package:tower_crane/ui/settings/music_button.dart';
import 'package:tower_crane/ui/settings/start_simulation_button.dart';
import 'package:tower_crane/ui/settings/wave_settings.dart';
import 'package:tower_crane/ui/settings/wind_settings.dart';
import '../responsive_size.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WindSettings(),
        SizedBox(
          height: 30.height,
        ),
        WaveSettings(),
        SizedBox(
          height: 30.height,
        ),
        StartSimulationButton(),
        SizedBox(
          height: 30.height,
        ),
        MusicButton(),
      ],
    );
  }
}