import 'package:flutter/material.dart';
import 'package:tower_crane/ui/painters_layout/ship_side_painter.dart';
import 'package:tower_crane/ui/painters_layout/ship_top_painter.dart';
import '../responsive_size.dart';
class PaintersLayout extends StatelessWidget {
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
      width: 1172.width,
      child: Column(
        children: [
          Container(
            height: 357.height,
            width: 1536.width,
            child: CustomPaint(
              painter: ShipTopPainter(),
            ),
          ),
          Divider(
            thickness: 2,
          ),
          Container(
            height: 357.height,
            width: 1536.width,
            child: CustomPaint(
              painter: ShipSidePainter(),
            ),
          ),
        ],
      ),
    );
  }
}
