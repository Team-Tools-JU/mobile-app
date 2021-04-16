import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/connect/connect_view_model.dart';

class Devices extends StatelessWidget {
  final ConnectViewModel _model;

  const Devices(this._model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _model.devices.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            child: TextButton(
                onPressed: () async =>
                    this._model.connect(this._model.devices[index]),
                child: Text(this._model.devices[index].name ?? "No name")),
            // child: Text(this._model.devices[index].id)),
          );
        });
  }
}
