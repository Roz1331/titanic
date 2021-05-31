import 'package:flutter/material.dart';
import 'package:tower_crane/ui/painters_layout/painters_layout.dart';
import 'package:tower_crane/ui/settings/settings.dart';

import 'responsive_size.dart';

class MainLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [PaintersLayout(), Settings()],
        ),
      ),
    );
  }
}
