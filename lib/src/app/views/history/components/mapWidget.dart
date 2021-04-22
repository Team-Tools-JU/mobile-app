import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/views/History/history_view_model.dart';
import '../history_view_model.dart';

class MapWidget extends StatefulWidget{
  final HistoryViewModel _model;
  const MapWidget(this._model, {Key key}) : super(key: key);
  @override
  _MapWidgetState createState() => _MapWidgetState();
}
class _MapWidgetState extends State<MapWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: Implement Map view properly
    return Center(
      child: Container(
          margin: const EdgeInsets.all(0.0),
          color: Colors.amber[600],
          alignment: Alignment.center,
          width: 200.0,
          height: 200.0,
          child: Text('Placeholder for map',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.white))
      ),

    );
  }
}