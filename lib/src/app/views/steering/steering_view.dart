import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/steering/components/steerButton.dart';
import 'package:mobile_app/src/app/views/steering/steering_view_model.dart';

import 'package:stacked/stacked.dart';

class SteeringView extends StatelessWidget {
  const SteeringView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SteeringViewModel>.reactive(
      viewModelBuilder: () => SteeringViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Steering"),
          actions: <Widget> [
            IconButton(
              icon: const Icon(Icons.bluetooth),
              color: Colors.black,
              tooltip: 'Bluetooth status',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(model.updateBluetoothStatus())));
              },
            )
          ],
        ),
        body: Center(
          child: SteerButton(model),
        ),
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
