import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/view_models/start_view_model.dart';
import 'package:mobile_app/src/app/views/start/components/body.dart';
import 'package:stacked/stacked.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartViewModel>.reactive(
      onModelReady: (model) async => model.init(),
      builder: (context, model, child) => Scaffold(
        body: Body(model),
      ),
      viewModelBuilder: () => StartViewModel(),
    );
  }
}
