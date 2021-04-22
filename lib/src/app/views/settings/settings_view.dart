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
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: SwitchButton(model),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(icon: Icon(Icons.home),
              label: 'Start',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.history),
                label: 'History')
          ],
          selectedItemColor: Colors.amber[800],
        ),
      ),
    );
  }
}
