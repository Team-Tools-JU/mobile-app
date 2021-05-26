import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/history/components/mower_sessions_stateless.dart';
import 'package:mobile_app/src/app/views/history/components/pathPainter.dart';
import 'package:mobile_app/src/app/view_models/history_view_model.dart';

class MowerPathStateless extends StatelessWidget {
  final HistoryViewModel model;
  const MowerPathStateless(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MowerSessionsStateless(model),
        Padding(
          padding: EdgeInsets.all(200.0),
          child: Container(
            child: CustomPaint(
              painter: PathPainter(),
            ),
          ),
        ),
      ],
    );
  }
}
