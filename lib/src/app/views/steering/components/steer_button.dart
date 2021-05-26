import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/steering/steering_view_model.dart';

class SteerButton extends StatelessWidget {
  final SteeringViewModel model;
  final String command;
  final IconData iconData;
  static const int greenBar = 0;
  static const int yellowBar = 1;
  static const int orangeBar = 2;
  static const int redBar = 3;

  const SteerButton(this.model, this.command, this.iconData, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70.0,
        width: 110.0,
        child: GestureDetector(
          onTapDown: (_) {
            model.send(command);
          },
          onTap: () {
            model.stopMower();
          },
          onLongPressEnd: (_) {
            model.stopMower();
          },
          child: Icon(iconData, size: 90.0),
        ));
  }
}
