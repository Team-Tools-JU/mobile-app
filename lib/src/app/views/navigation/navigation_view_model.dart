import 'package:flutter_blue/flutter_blue.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/src/app/models/implementation/bluetooth_v2.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class NavigationViewModel extends IndexTrackingViewModel {
  String bluetoothStatusText = 'default';
  bool isConnected = false;
  IconData iconData = Icons.bluetooth;
  Bluetooth _bluetooth = GetIt.I<Bluetooth>();

  NavigationViewModel() {
    _bluetooth.selectedDevice.state.listen((state) {
      switch (state) {
        case BluetoothDeviceState.connected:
          isConnected = true;
          break;
        case BluetoothDeviceState.disconnected:
          isConnected = false;
          break;
        default:
          break;
      }
    });
  }

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
      iconData = Icons.bluetooth_searching;
    }
    return _bluetoothIcon;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
