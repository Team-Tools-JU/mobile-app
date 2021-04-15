import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/connect/components/devices.dart';
import 'package:mobile_app/src/app/views/connect/connect_view_model.dart';

class Body extends StatelessWidget {
  final ConnectViewModel _model;

  const Body(this._model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
