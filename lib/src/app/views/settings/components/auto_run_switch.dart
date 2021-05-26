import 'package:flutter/material.dart';
import 'lite_rolling_switch.dart';
import 'package:mobile_app/src/app/models/constants/text_constants.dart';
import 'package:mobile_app/src/app/view_models/settings_view_model.dart';

class AutoRunSwitch extends StatelessWidget {
  final SettingsViewModel model;

  const AutoRunSwitch(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(19.0),
          child: Text(
            AUTO_DRIVING,
            style: TextStyle(fontSize: 25),
          ),
        ),
        Container(
          height: 40,
          width: 125,
          child: !model.isConnected
              ? Text(
                  CONNECTION_REQUIRED,
                  style: TextStyle(fontSize: 18),
                )
              : LiteRollingSwitch(
                  value: model.autoDriving,
                  textOn: SWITCH_ON,
                  textOff: SWITCH_OFF,
                  colorOn: Colors.greenAccent,
                  colorOff: Colors.redAccent,
                  iconOn: Icons.done,
                  iconOff: Icons.power_settings_new,
                  textSize: 18.0,
                  onChanged: (bool isEnabled) {
                    model.autoDriving = isEnabled ? true : false;
                    model.toggleAutoDrive();
                  },
                ),
        )
      ],
    );
  }
}
