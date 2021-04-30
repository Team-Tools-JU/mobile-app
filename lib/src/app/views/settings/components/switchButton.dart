import 'package:flutter/material.dart';
import '../settings_view_model.dart';
// import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'lite_rolling_switch.dart';

class SwitchButton extends StatefulWidget {
  final SettingsViewModel model;

  const SwitchButton(this.model, {Key? key}) : super(key: key);

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(19.0),
                child: Text(
                  'Simulation mode',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                height: 40,
                width: 125,
                child: LiteRollingSwitch(
                  value: false,
                  textOn: 'ON',
                  textOff: 'OFF',
                  colorOn: Colors.greenAccent,
                  colorOff: Colors.redAccent,
                  iconOn: Icons.done,
                  iconOff: Icons.power_settings_new,
                  textSize: 18.0,
                  onChanged: (bool position) {
                    print('The button is $position');
                    // TODO: Change variable state
                  },
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(19.0),
                child: Text(
                  'Manual steering',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Container(
                height: 40,
                width: 125,
                child: LiteRollingSwitch(
                  value: false,
                  textOn: 'ON',
                  textOff: 'OFF',
                  colorOn: Colors.greenAccent,
                  colorOff: Colors.redAccent,
                  iconOn: Icons.done,
                  iconOff: Icons.power_settings_new,
                  textSize: 18.0,
                  onChanged: (bool position) {
                    print('The button is $position');
                    // TODO: Change variable state
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
