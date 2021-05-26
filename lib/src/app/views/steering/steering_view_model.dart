import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/src/app/models/implementation/bluetooth.dart';
import 'package:mobile_app/src/app/models/constants/mower_commands.dart';
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
  int _signalStrength = 0;

  get signalStrength => _signalStrength;

  String get _bluetoothStatusText => bluetoothStatusText;
  IconData get _bluetoothIcon => iconData;

  void init() {
    bluetoothStatusText = 'initialised';
    isConnected = false;

    _bluetooth.isConnectedStream.stream.listen((state) async {
      _bluetooth.isConnected = isConnected = state;

      if (!isConnected) {
        await _bluetooth.disconnect();
        _navigationController.currentIndex = 0;
        Get.off(NavigationView());
      }
    });

    _bluetooth.listen();
    _bluetooth.reciever.stream.listen((msg) {
      print("message from reciever: $msg");

      int distance = int.tryParse(msg) ?? 0;
      setSignalStrength(distance);
    });
  }

  void setSignalStrength(int distance) {
    switch (distance) {
      case 1:
        _signalStrength = 4;
        break;
      case 2:
        _signalStrength = 3;
        break;
      case 3:
        _signalStrength = 2;
        break;
      case 4:
        _signalStrength = 1;
        break;
      default:
        _signalStrength = 0;
        break;
    }

    print("strength $signalStrength");
    signal();
    notifyListeners();
  }

  int signal() {
    return _signalStrength;
  }

  void stopMower() {
    Future.delayed(Duration(seconds: 1), () => {send(MOWER_IDLE)});
  }

  void send(String command) {
    _bluetooth.write(command);
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
