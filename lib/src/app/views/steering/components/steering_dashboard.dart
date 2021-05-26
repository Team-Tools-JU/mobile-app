import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/models/constants/mower_commands.dart';
import 'package:mobile_app/src/app/models/constants/text_constants.dart';
import 'package:mobile_app/src/app/views/steering/components/signal_strength_wrapper.dart';
import 'package:mobile_app/src/app/views/steering/components/steer_button.dart';
import 'package:mobile_app/src/app/view_models/steering_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SteeringDashboard extends StatelessWidget {
  final SteeringViewModel model;
  static const int greenBar = 0;
  static const int yellowBar = 1;
  static const int orangeBar = 2;
  static const int redBar = 3;

  const SteeringDashboard(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Container(child: Text("{$model.signalStrength}")),
        Center(),
        SignalStrengthWrapper(model),
        Container(
          margin: EdgeInsets.all(20),
          height: 100.0,
          width: 150.0,
          child: Text(COLLISION_LABEL),
        ),
        SteerButton(
            model, MOWER_FORWARD, FontAwesomeIcons.solidArrowAltCircleUp),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SteerButton(
                model, MOWER_LEFT, FontAwesomeIcons.solidArrowAltCircleLeft),
            SteerButton(
                model, MOWER_RIGHT, FontAwesomeIcons.solidArrowAltCircleRight),
          ],
        ),
        SteerButton(
            model, MOWER_BACKWARD, FontAwesomeIcons.solidArrowAltCircleDown),
      ],
    );
  }
}
