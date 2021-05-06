import 'package:flutter/material.dart';
import '../start_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Body extends StatelessWidget {
  final StartViewModel model;

  const Body(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (!this.model.isConnected)
            SpinKitFadingCircle(size: 100, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            !this.model.isConnected
                ? 'Trying to connect....'
                : 'Connection established to mower.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
