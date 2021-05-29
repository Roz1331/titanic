import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tower_crane/stupid_constants.dart';
import 'package:tower_crane/ui/painters_layout/ship_side_painter.dart';
import 'package:tower_crane/ui/painters_layout/ship_top_painter.dart';
import 'package:tower_crane/world_state.dart';

import '../responsive_size.dart';

class PaintersLayout extends StatefulWidget {
  @override
  _PaintersLayoutState createState() => _PaintersLayoutState();
}

class _PaintersLayoutState extends State<PaintersLayout> {
  Timer timer;
  double radians = 0.0;
  Offset tappedPosition = Offset(0,0);
  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        radians += 0.01;
      });
      WorldState.shipZ += WaveDimensions.amplitude *
          (WorldState.waveFunction(radians) -
              WorldState.waveFunction(radians - 0.01));
      WorldState.waveZ += WaveDimensions.amplitude *
          (WorldState.waveFunction(radians) -
              WorldState.waveFunction(radians - 0.01));
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 2,
          ),
        ),
      ),
      width: 1172.w,
      child: Column(
        children: [
          Container(
            height: 357.h,
            width: 1536.w,
            child: GestureDetector(
              onTapDown: (details) {
                var coord = checkBoxCoord(Offset(details.globalPosition.dx, details.globalPosition.dy));
                if(WorldState.boxPlaces[coord] < 4){
                  WorldState.currentTarget = coord;
                }
                setState(() {
                  tappedPosition = Offset(details.globalPosition.dx, details.globalPosition.dy);
                });
              },
              child: CustomPaint(
                painter: ShipTopPainter(tappedPosition),
              ),
            ),
          ),
          Container(
            height: 357.h,
            width: 1536.w,
            child: CustomPaint(
              painter: ShipSidePainter(radians),
            ),
          ),
        ],
      ),
    );
  }

  int checkBoxCoord(Offset tappedPosition){
    for (int i = 0; i < 12; i++){
      var x = WorldState.shipX - (ContainerBoxDimensions.length * 3) + ContainerBoxDimensions.length * (i % 6);
      var y = WorldState.shipY - ContainerBoxDimensions.width + ContainerBoxDimensions.width * (i ~/ 6);
      var rect = Rect.fromPoints(Offset(x.w,y.h), Offset((x + ContainerBoxDimensions.length).w, (y + ContainerBoxDimensions.width).h));
      if(rect.contains(tappedPosition)){
        return i;
      }
    }
  }
}
