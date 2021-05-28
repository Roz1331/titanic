import 'package:flutter/material.dart';
import '../responsive_size.dart';

class StartSimulationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          Size(283.width, 80.height),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          Color(0xFF000060),
        ),
      ),
      onPressed: () {
        
      },
      icon: Icon(
        Icons.play_arrow_rounded,
        color: Colors.green,
        size: 50,
      ),
      label: Text(
        "НАЧАТЬ",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }
}
