import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/steering/components/signal_strength_indicator/signal_strength_indicator.dart';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../steering_view_model.dart';

class SignalStrength extends StatelessWidget {
  final SteeringViewModel model;
  static const int greenBar = 4;
  static const int yellowBar = 3;
  static const int redBar = 2;

  const SignalStrength(this.model, {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: Transform.rotate(
        angle: -45 * pi / 180,
        origin: const Offset(-50, 0),
        child: SignalStrengthIndicator.sector(
          // TODO: Receive data from mower
          value: model.signal(),
          maxValue: 4,
          minValue: 0,
          size: 150,
          spacing: 0.5,
          barCount: 4,
          // ignore: prefer_const_literals_to_create_immutables
          //levels: <num, Color>{
          //  redBar: Colors.red,
          // yellowBar: Colors.yellow,
          // greenBar: Colors.green,
          //},
          inactiveColor: Colors.blue[100],
        ),
      ),
    );
  }
}
