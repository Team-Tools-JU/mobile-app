import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/models/constants/text_constants.dart';
import 'package:mobile_app/src/app/views/steering/components/steering_dashboard.dart';
import 'package:mobile_app/src/app/view_models/steering_view_model.dart';
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
          title: Text(STEERING_LABEL),
          actions: <Widget>[
            IconButton(
              icon: Icon(model.updateBluetoothSymbolText()),
              color: Colors.black,
              tooltip: BT_TOOLTIP,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(model.updateBluetoothStatusText())));
              },
            )
          ],
        ),
        body: Center(
          child: SteeringDashboard(model),
        ),
      ),
    );
  }
}
