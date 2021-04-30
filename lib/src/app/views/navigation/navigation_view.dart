import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/history/history_view.dart';
import 'package:mobile_app/src/app/views/navigation/navigation_view_model.dart';
import 'package:mobile_app/src/app/views/settings/settings_view.dart';
import 'package:mobile_app/src/app/views/start/start_view.dart';

import 'package:stacked/stacked.dart';

import '../start/start_view.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(viewTitle(model.currentIndex)),
          actions: <Widget>[
            IconButton(
              icon: Icon(model.updateBluetoothSymbolText()),
              color: Colors.black,
              tooltip: 'Bluetooth status',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(model.updateBluetoothStatusText())));
              },
            )
          ],
        ),
        body: getViewForIndex(model.currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Start',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: model.currentIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          iconSize: 40,
          onTap: model.setIndex,
          elevation: 5,
        ),
      ),
      viewModelBuilder: () => NavigationViewModel(),
    );
  }

  String viewTitle(int index) {
    switch (index) {
      case 0:
        return 'Mower-app';
      case 1:
        return 'Settings';
      case 2:
        return 'History';
      default:
        return '';
    }
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return StartView();
      case 1:
        return SettingsView();
      case 2:
        return HistoryView();
      default:
        return StartView();
    }
  }
}
