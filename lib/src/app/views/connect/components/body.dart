import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:mobile_app/src/app/views/connect/components/devices.dart';
import 'package:mobile_app/src/app/views/connect/connect_view_model.dart';

class Body extends StatelessWidget {
  final ConnectViewModel _model;

  const Body(this._model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _showRequestDialog(context);

    return Container(
      margin: const EdgeInsets.only(
          left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Devices",
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 10),
          Flexible(child: Devices(_model)),
        ],
      ),
    );
  }

  _showRequestDialog(BuildContext context) {
    // Future.delayed(
    //     Duration(seconds: 1),
    //     () =>
    _model.servicesEnabled.stream.listen((enabled) {
      if (!enabled) {
        print("new dialogbox");
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                  title: new Text("Required"),
                  content: new Text(
                      "Bluetooth and location services are required for the app to function."),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Try again'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _model.requestPermissions();
                      },
                    )
                  ]);
            });
      }
    });
  }
}
