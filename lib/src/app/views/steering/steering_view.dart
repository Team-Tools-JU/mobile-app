import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/steering/components/steerButton.dart';
import 'package:mobile_app/src/app/views/steering/steering_view_model.dart';
import 'package:stacked/stacked.dart';

class SteeringView extends StatelessWidget {
  const SteeringView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SteeringViewModel>.reactive(
      viewModelBuilder: () => SteeringViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => {model.disableSteering()},
          ),
          title: Text("Steering"),
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
        body: Center(
          child: SteerButton(model),
        ),
      ),
    );
  }
}
