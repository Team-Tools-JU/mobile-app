import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class NavigationViewModel extends IndexTrackingViewModel {

  String bluetoothStatusText = 'default';
  bool isConnected = false;
  IconData iconData = Icons.bluetooth;

  String get _bluetoothStatusText => bluetoothStatusText;
  IconData get _bluetoothIcon => iconData;

  String updateBluetoothStatusText() {
    if (isConnected) {
      bluetoothStatusText = 'Connected!';
    } else {
      bluetoothStatusText = 'Not connected!';
    }
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
