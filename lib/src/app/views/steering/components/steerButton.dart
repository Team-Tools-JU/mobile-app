
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/steering/steering_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SteerButton extends StatefulWidget {

  final SteeringViewModel _model;

  const SteerButton(this._model, {Key key}) : super(key: key);

  @override
  _SteerButtonState createState() => _SteerButtonState();
}

class _SteerButtonState extends State<SteerButton> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 150.0,
          child: Icon(
            Icons.wifi, size: 150.0,),
        ),
        Container(
          height: 150.0,
          child: Text('Collision detection'),

        ),
        Container(
          height: 70.0,
          width: 110.0,
          child: IconButton(
            icon: FaIcon(FontAwesomeIcons.solidArrowAltCircleUp, size: 100.0),
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
                  icon: FaIcon(FontAwesomeIcons.solidArrowAltCircleLeft, size: 100.0),
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
                  icon: FaIcon(FontAwesomeIcons.solidArrowAltCircleRight, size: 100.0),
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
              icon: FaIcon(FontAwesomeIcons.solidArrowAltCircleDown, size: 100.0),
              onPressed: (){
                setState(() {
                  print('Down arrow pressed');
                  // TODO: Send data to mower
                });
              },
            )
        ),
      ],
    );
  }
}