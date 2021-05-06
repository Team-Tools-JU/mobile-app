import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/src/app/models/implementation/settings_controller.dart';
import 'package:mobile_app/src/app/views/navigation/navigation_view.dart';

class SteeringViewModel extends ChangeNotifier {
  SettingsController _controller = GetIt.I<SettingsController>();
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
      iconData = Icons.bluetooth_searching;
    }
    return _bluetoothIcon;
  }

  void disableSteering() {
    _controller.steeringEnabled.add(false);
    notifyListeners();
    Get.off(NavigationView());
  }

  @override
  void dispose() {
    super.dispose();
  }
}
