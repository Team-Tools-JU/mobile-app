import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:mobile_app/src/app/views/steering/components/signal_strength_indicator/signal_strength_indicator.dart';
import 'package:mobile_app/src/app/view_models/steering_view_model.dart';

class SignalStrengthWrapper extends StatelessWidget {
  final SteeringViewModel model;
  static const int greenBar = 0;
  static const int yellowBar = 1;
  static const int orangeBar = 2;
  static const int redBar = 3;

  const SignalStrengthWrapper(this.model, {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: Transform.rotate(
        angle: -45 * pi / 180,
        origin: const Offset(-50, 0),
        child: SignalStrengthIndicator.sector(
          value: model.signalStrength,
          maxValue: 4,
          minValue: 0,
          size: 150,
          spacing: 0.5,
          barCount: 4,
          // ignore: prefer_const_literals_to_create_immutables
          levels: <num, Color>{
            greenBar: Colors.green,
            yellowBar: Colors.yellow,
            orangeBar: Colors.orange,
            redBar: Colors.red,
          },
          inactiveColor: Colors.blue[100],
        ),
      ),
    );
  }
}
