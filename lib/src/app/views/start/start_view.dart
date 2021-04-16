import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/start/start_view_model.dart';
import 'package:mobile_app/src/app/views/start/components/body.dart';

import 'package:stacked/stacked.dart';

class StartView extends StatelessWidget {
  const StartView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartViewModel>.reactive(
      viewModelBuilder: () => StartViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Mower-app"),
          actions: <Widget> [
            IconButton(
              icon: const Icon(Icons.bluetooth),
              color: Colors.black,
              tooltip: 'Bluetooth status',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Not connected')));
              },
            )
          ],
        ),
        body: Body(model),
        floatingActionButton: FloatingActionButton(
          onPressed: () => model.incrementCounter(),
          child: Icon(Icons.ac_unit),
        ),
      ),
    );
  }
}
