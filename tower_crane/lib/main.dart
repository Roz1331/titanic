import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:tower_crane/ui/main_layout.dart';
import 'package:tower_crane/ui/responsive_size.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Титаник',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        ResponsiveSize.init(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        );
        return child;
      },
      home: MainLayout(),
    );
  }
}
