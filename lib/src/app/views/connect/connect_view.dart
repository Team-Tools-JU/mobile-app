import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:mobile_app/src/app/views/connect/components/body.dart';
import 'package:mobile_app/src/app/views/connect/connect_view_model.dart';

class ConnectView extends StatelessWidget {
  const ConnectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConnectViewModel>.reactive(
      viewModelBuilder: () => ConnectViewModel(),
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: false,
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(
              "Connect",
            ),
            backgroundColor: Color(0xFFFF9800),
            actions: <Widget>[
              IconButton(
                //textColor: Colors.white,
                onPressed: () {
                  model.scan();
                },
                icon: Icon(Icons.refresh, color: Colors.white, size: 30),
              ),
            ],
          ),
          body: Body(model)),
    );
  }
}
