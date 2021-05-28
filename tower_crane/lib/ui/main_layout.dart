import 'package:flutter/material.dart';
import 'package:tower_crane/ui/painters_layout/painters_layout.dart';
import 'package:tower_crane/ui/settings/settings.dart';

import 'responsive_size.dart';

class MainLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            PaintersLayout(),
            Container(
              padding: EdgeInsets.only(
                top: 79.h,
              ),
              width: 364.w,
              child: Settings(),
            )
          ],
        ),
      ),
    );
  }
}
