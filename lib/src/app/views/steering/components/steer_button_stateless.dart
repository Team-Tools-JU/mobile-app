import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/models/implementation/mower_commands.dart';
import 'package:mobile_app/src/app/views/steering/components/signal_strength_indicator/signal_strength_indicator.dart';
import 'package:mobile_app/src/app/views/steering/steering_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

class SteerButtonStateless extends StatelessWidget {
  final SteeringViewModel model;
  static const int greenBar = 0;
  static const int yellowBar = 1;
  static const int orangeBar = 2;
  static const int redBar = 3;

  const SteerButtonStateless(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Container(child: Text("{$model.signalStrength}")),
        Center(),
        Container(
          height: 150.0,
          child: Transform.rotate(
            angle: -45 * pi / 180,
            origin: const Offset(-50, 0),
            child: SignalStrengthIndicator.sector(
              // TODO: Receive data from mower
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
        ),
        Container(
          margin: EdgeInsets.all(20),
          height: 100.0,
          width: 150.0,
          child: Text('Collision detection'),
        ),
        Container(
            height: 70.0,
            width: 110.0,
            child: GestureDetector(
              onTapDown: (_) {
                model.send(MOWER_FORWARD);
              },
              onTap: () {
                model.stopMower();
              },
              onLongPressEnd: (_) {
                model.stopMower();
              },
              child: Icon(FontAwesomeIcons.solidArrowAltCircleUp, size: 90.0),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                height: 70.0,
                width: 110.0,
                child: GestureDetector(
                  onTapDown: (_) {
                    model.send(MOWER_LEFT);
                  },
                  onTap: () {
                    model.stopMower();
                  },
                  onLongPressEnd: (_) {
                    model.stopMower();
                  },
                  child: Icon(FontAwesomeIcons.solidArrowAltCircleLeft,
                      size: 90.0),
                )),
            Container(
                height: 70.0,
                width: 110.0,
                child: GestureDetector(
                  onTapDown: (_) {
                    model.send(MOWER_RIGHT);
                  },
                  onTap: () {
                    model.stopMower();
                  },
                  onLongPressEnd: (_) {
                    model.stopMower();
                  },
                  child: Icon(FontAwesomeIcons.solidArrowAltCircleRight,
                      size: 90.0),
                )),
          ],
        ),
        Container(
            height: 70.0,
            width: 110.0,
            child: GestureDetector(
              onTapDown: (_) {
                model.send(MOWER_BACKWARD);
              },
              onTap: () {
                model.stopMower();
              },
              onLongPressEnd: (_) {
                model.stopMower();
              },
              child: Icon(FontAwesomeIcons.solidArrowAltCircleDown, size: 90.0),
            )),
      ],
    );
  }
}
