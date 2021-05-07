import 'package:flutter/material.dart';
import '../settings_view_model.dart';
import 'lite_rolling_switch.dart';

class SwitchButtonStateless extends StatelessWidget {
  final SettingsViewModel model;

  const SwitchButtonStateless(this.model, {Key? key}) : super(key: key);

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
                child: !model.isConnected
                    ? Text(
                        "Must be connected.",
                        style: TextStyle(fontSize: 18),
                      )
                    : LiteRollingSwitch(
                        value: model.manualSteering,
                        textOn: 'ON',
                        textOff: 'OFF',
                        colorOn: Colors.greenAccent,
                        colorOff: Colors.redAccent,
                        iconOn: Icons.done,
                        iconOff: Icons.power_settings_new,
                        textSize: 18.0,
                        onChanged: (bool isEnabled) {
                          if (isEnabled) {
                            model.activateSteering();
                          }
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
