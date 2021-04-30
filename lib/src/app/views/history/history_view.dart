import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/history/components/mapWidget.dart';
import 'package:mobile_app/src/app/views/history/history_view_model.dart';
import 'package:stacked/stacked.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      viewModelBuilder: () => HistoryViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: MapWidget(model),
      ),
    );
  }
}
