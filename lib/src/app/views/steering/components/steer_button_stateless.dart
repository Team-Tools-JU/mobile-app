import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/models/implementation/mower_commands.dart';
import 'package:mobile_app/src/app/views/steering/steering_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signal_strength_indicator/signal_strength_indicator.dart';
import 'dart:math';

class SteerButtonStateless extends StatelessWidget {
  final SteeringViewModel model;
  static const double greenBar = 0.75;
  static const double yellowBar = 0.50;
  static const double redBar = 0.25;

  const SteerButtonStateless(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 150.0,
          child: Transform.rotate(
            angle: -45 * pi / 180,
            origin: const Offset(-50, 0),
            child: SignalStrengthIndicator.sector(
              // TODO: Receive data from mower
              value: model.signalStrength,
              size: 150,
              spacing: 0.5,
              barCount: 3,
              // ignore: prefer_const_literals_to_create_immutables
              levels: <num, Color>{
                redBar: Colors.red,
                yellowBar: Colors.yellow,
                greenBar: Colors.green,
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
