import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/steering/steering_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signal_strength_indicator/signal_strength_indicator.dart';
import 'dart:math';


class SteerButton extends StatefulWidget {

  final SteeringViewModel model;

  const SteerButton(this.model, {Key key}) : super(key: key);

  @override
  _SteerButtonState createState() => _SteerButtonState();
}

class _SteerButtonState extends State<SteerButton> {

  double _signalStrength = 0.0;

  void _changeValue(double value) {
    setState(() {
      print(_signalStrength.toString());
      _signalStrength = value;
    });
  }


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
              value: _signalStrength,
              size: 150,
              spacing: 0.5,
              barCount: 3,
              // ignore: prefer_const_literals_to_create_immutables
              levels: <num, Color>{
                0.25: Colors.red,
                0.50: Colors.yellow,
                0.75: Colors.green,
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
          child: IconButton(
            icon: FaIcon(FontAwesomeIcons.solidArrowAltCircleUp, size: 90.0),
            onPressed: (){
              setState(() {
                print('Up arrow pressed');
                // TODO: Send data to mower
              });
            },
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 70.0,
              width: 110.0,
              child: IconButton(
                  icon: FaIcon(FontAwesomeIcons.solidArrowAltCircleLeft, size: 90.0),
                  onPressed: (){
                    setState(() {
                      print('Left arrow pressed');
                      // TODO: Send data to mower
                    });
                  },
                ),
            ),
            Container(
                height: 70.0,
                width: 110.0,
                child: IconButton(
                  icon: FaIcon(FontAwesomeIcons.solidArrowAltCircleRight, size: 90.0),
                  onPressed: (){
                    setState(() {
                      print('Right arrow pressed');
                      // TODO: Send data to mower
                    });
                  },
                )
            ),
          ],
        ),
        Container(
            height: 70.0,
            width: 110.0,
            child: IconButton(
              icon: FaIcon(FontAwesomeIcons.solidArrowAltCircleDown, size: 90.0),
              onPressed: (){
                setState(() {
                  print('Down arrow pressed');
                  // TODO: Send data to mower
                });
              },
            )
        ),
        Slider (
          value: _signalStrength,
          onChanged: _changeValue,
        ),
      ],
    );
  }
}