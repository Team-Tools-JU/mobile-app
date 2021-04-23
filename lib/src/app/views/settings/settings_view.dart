import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/settings/settings_view_model.dart';
import 'package:mobile_app/src/app/views/settings/components/switchButton.dart';

import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: SwitchButton(model),
      ),
    );
  }
}
