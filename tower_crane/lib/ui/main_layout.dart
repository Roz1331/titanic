import 'package:flutter/material.dart';
import 'package:tower_crane/ui/painters_layout/painters_layout.dart';
import 'package:tower_crane/ui/settings/settings.dart';
import 'package:tower_crane/ui/painters_layout/ship_side_painter.dart';
import 'package:tower_crane/ui/painters_layout/ship_top_painter.dart';
import 'responsive_size.dart';

class MainLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("main height " + MediaQuery.of(context).size.height.toString());
    print("main width " + MediaQuery.of(context).size.width.toString());
    print(MediaQuery.of(context).devicePixelRatio);
    //print("main pixel ratio " + MediaQuery.of(context).size.);
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            PaintersLayout(),
            Container(
              padding: EdgeInsets.only(
                top: 79.height,
              ),
              width: 364.width,
              child: Settings(),
            )
          ],
        ),
      ),
    );
  }
}
