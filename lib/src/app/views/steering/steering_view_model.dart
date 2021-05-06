import 'package:flutter/material.dart';

class SteeringViewModel extends ChangeNotifier {

  String bluetoothStatusText = 'default';
  bool isConnected = false;
  IconData iconData = Icons.bluetooth;

  String get _bluetoothStatusText => bluetoothStatusText;
  IconData get _bluetoothIcon => iconData;

  void init() {

    bluetoothStatusText = 'initialised';
    isConnected = false;
    notifyListeners();
  }

  String updateBluetoothStatusText() {

    if (isConnected) {
      bluetoothStatusText = 'Connected!';
    } else {
      bluetoothStatusText = 'Not connected!';
    }
    notifyListeners();
    return _bluetoothStatusText;
  }

  IconData updateBluetoothSymbolText() {

    if (isConnected) {
      iconData = Icons.bluetooth_connected;
    } else {
      iconData =Icons.bluetooth_searching;
    }
    return _bluetoothIcon;
  }

  @override
  void dispose() {

    super.dispose();
  }
}
