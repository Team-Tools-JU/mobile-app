import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/src/app/models/implementation/bluetooth.dart';
import 'package:mobile_app/src/app/models/implementation/navigation_controller.dart';
import 'package:mobile_app/src/app/models/implementation/settings_controller.dart';
import 'package:mobile_app/src/app/views/navigation/navigation_view.dart';
import 'package:stacked/stacked.dart';

class SteeringViewModel extends BaseViewModel {
  SettingsController _settingsController = GetIt.I<SettingsController>();
  NavigationController _navigationController = GetIt.I<NavigationController>();

  Bluetooth _bluetooth = GetIt.I<Bluetooth>();
  String bluetoothStatusText = 'default';
  bool isConnected = false;
  IconData iconData = Icons.bluetooth;

  double _signalStrength = 1.0;

  get signalStrength => _signalStrength;

  String get _bluetoothStatusText => bluetoothStatusText;
  IconData get _bluetoothIcon => iconData;

  void init() {
    print("init steering view");
    bluetoothStatusText = 'initialised';
    isConnected = false;
    // notifyListeners();

    _bluetooth.isConnected.stream.listen((state) {
      isConnected = state;

      if (isConnected) {
        // List<int> value = utf8.encode("AR");
        // // print(value1);
        // // List<int> value = [77, 70];
        // await c.write([65, 82], withoutResponse: true);
        // print(value);
        // readChar = c;

      } else {
        _navigationController.currentIndex = 0;
        Get.back();
      }
    });
  }

  void write() {
    _bluetooth.write("AR");
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
    _settingsController.steeringEnabled.add(false);
    notifyListeners();
    Get.off(NavigationView());
  }

  @override
  void dispose() {
    super.dispose();
  }
}
