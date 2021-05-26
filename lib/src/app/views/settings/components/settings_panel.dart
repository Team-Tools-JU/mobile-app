import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/settings/components/auto_run_switch.dart';
import 'package:mobile_app/src/app/views/settings/components/manual_steer_switch.dart';
import '../../../view_models/settings_view_model.dart';

class SettingsPanel extends StatelessWidget {
  final SettingsViewModel model;

  const SettingsPanel(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[AutoRunSwitch(model), ManualSteerSwitch(model)],
      ),
    );
  }
}
