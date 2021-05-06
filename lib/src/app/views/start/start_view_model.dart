import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/app/models/implementation/bluetooth_constants.dart';
import 'package:mobile_app/src/app/views/settings/settings_view.dart';
import 'package:stacked/stacked.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:get_it/get_it.dart';
import 'package:mobile_app/src/app/models/implementation/android_service.dart';
import 'package:mobile_app/src/app/models/implementation/bluetooth.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:location/location.dart' as L;
import 'package:permission_handler/permission_handler.dart';

class StartViewModel extends IndexTrackingViewModel {
  Bluetooth _bluetooth = GetIt.I<Bluetooth>();
  L.Location _location = new L.Location();
  AndroidService _android = GetIt.I<AndroidService>();

  StreamController<bool> servicesEnabled = StreamController<bool>.broadcast();
  StreamController<bool> permissionsGiven = StreamController<bool>.broadcast();

  String bluetoothStatusText = 'default';
  bool isConnected = false;

  String get _bluetoothStatusText => bluetoothStatusText;

  StartViewModel() {
    init();
  }

  void init() async {
    bluetoothStatusText = 'initialised';
    isConnected = false;

    permissionsGiven.stream.listen((permitted) {
      if (permitted) {
        onPermissionsGiven();
      } else {
        showRequestDialog();
      }
    });

    _bluetooth.flutterBlue.state.listen((state) async {
      switch (state) {
        case BluetoothState.turningOff:
        case BluetoothState.off:
          showRequestDialog();
          break;
        case BluetoothState.on:
          if (await _location.requestService()) {
            scan();
          } else {
            showRequestDialog();
          }
          break;
        default:
          break;
      }
    });

    await requestPermissions();
  }

  void onScanResults(List<BluetoothDevice> devices) {
    for (BluetoothDevice device in devices) {
      if (device.id.id == DEVICE_ID) {
        connect(device);
      }
      print('${device.name} ${device.id} found!');
    }
    notifyListeners();
  }

  void showRequestDialog() {
    final String title = "Required";
    final String msg =
        "Bluetooth and location services are required for the app to function.";
    final String btnText = "Try again";
    Get.rawSnackbar(
        title: title,
        message: msg,
        mainButton: TextButton(
          child: Text(btnText),
          onPressed: () {
            Get.back();
            requestPermissions();
          },
        ),
        duration: Duration(seconds: 10));
  }

  Future<void> onPermissionsGiven() async {
    if (!await _location.requestService() ||
        !await _bluetooth.flutterBlue.isOn) {
      _android.openBluetoothSetting();
    } else {
      scan();
    }
  }

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.location,
    ].request();

    bool locationPermitted = statuses[Permission.location]?.isGranted ?? false;
    bool bluetoothPermitted =
        statuses[Permission.bluetooth]?.isGranted ?? false;

    permissionsGiven.add(locationPermitted && bluetoothPermitted);
  }

  Future<bool> scan() async {
    try {
      List<BluetoothDevice> scanResults =
          await _bluetooth.scan(Duration(seconds: 4));
      onScanResults(scanResults);
      notifyListeners();
      return true;
    } catch (e) {
      print("bluetooth not ready or enabled, or location not enabled");
      print(e);
      // TODO: "Notify view of failed scan"
      return false;
    }
  }

  Future<void> connect(BluetoothDevice device) async {
    _bluetooth.selectedDevice = device;
    try {
      await _bluetooth.connect();
      _bluetooth.isConnected.add(true);
      isConnected = true;
      notifyListeners();
      print('connected to address: ${device.id} name: ${device.name}');
      Future.delayed(Duration(seconds: 2), () => Get.to(SettingsView()));
    } catch (e) {
      print(e);
      print('connection failed to address: ${device.id} name: ${device.name}');
    }
  }

  String updateBluetoothStatus() {
    if (isConnected) {
      bluetoothStatusText = 'Connected!';
    } else {
      bluetoothStatusText = 'Not connected!';
    }
    notifyListeners();
    return _bluetoothStatusText;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
