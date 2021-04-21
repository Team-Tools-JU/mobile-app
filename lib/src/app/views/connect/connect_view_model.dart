import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:mobile_app/src/app/models/implementation/bluetooth.dart';
import 'package:mobile_app/src/app/models/interfaces/bluetooth.dart';
import 'package:stacked/stacked.dart';

import 'package:permission_handler/permission_handler.dart';

class ConnectViewModel extends BaseViewModel {
  List<BTDevice> devices = [];
  final Bluetooth _bluetooth = Bluetooth();
  final Duration _scanDuration = Duration(seconds: 5);

  ConnectViewModel() {
    init();
  }

  Future<void> init() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.location,
    ].request();
    print(statuses[Permission.location]);
    print(statuses[Permission.bluetooth]);
    print("both permissions given");

    await Future.delayed(Duration(seconds: 1), () => {scan()});
  }

  Future<bool> scan() async {
    try {
      if (_bluetooth.isReady() &
          await Permission.locationWhenInUse.serviceStatus.isEnabled) {
        devices.clear();
        notifyListeners();
        devices = await _bluetooth.scan(_scanDuration);
        print("scan complete");
        notifyListeners();
        return true;
      } else {
        print("bluetooth not ready or enabled, or location not enabled");
        //_showDialog();
        //alert something
      }
    } catch (e) {}
    return false;
  }

  Future<void> connect(BTDevice device) async {
    await _bluetooth.connect(device);
    if (_bluetooth.isConnected) {
      print('connected to address: ${device.id} name: ${device.name}');
    } else {
      print('connection failed to address: ${device.id} name: ${device.name}');
    }
  }
}
