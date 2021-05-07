import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/history/components/mowerSessions.dart';
import 'package:mobile_app/src/app/views/history/components/pathPainter.dart';
import 'package:mobile_app/src/app/views/history/history_view_model.dart';

class MapWidget extends StatefulWidget {
  final HistoryViewModel model;
  const MapWidget(this.model, {Key? key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        MowerSessions(),
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
