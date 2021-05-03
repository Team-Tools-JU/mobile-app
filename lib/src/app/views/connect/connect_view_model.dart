import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/src/app/models/implementation/android_service.dart';
import 'package:mobile_app/src/app/models/implementation/bluetooth_v2.dart';
import 'package:mobile_app/src/app/views/connect/connect_view.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:location/location.dart' as L;
import 'package:mobile_app/src/app/models/implementation/bluetooth_constants.dart';
import 'package:permission_handler/permission_handler.dart';

class ConnectViewModel extends BaseViewModel {
  Bluetooth _bluetooth = GetIt.I<Bluetooth>();
  L.Location _location = new L.Location();

  AndroidService _android = GetIt.I<AndroidService>();
  List<BluetoothDevice> devices = [];

  bool isConnected = false;
  StreamController<bool> servicesEnabled = StreamController<bool>.broadcast();
  StreamController<bool> permissionsGiven = StreamController<bool>.broadcast();

  ConnectViewModel() {
    init();
  }

  Future<void> init() async {
    _bluetooth.flutterBlue.scanResults.listen((results) {
      onScanResults(results);
    });

    // _bluetooth.flutterBlue.state.listen((state) {
    //   if (state == BluetoothState.off) {}
    // });

    permissionsGiven.stream.listen((permitted) {
      if (permitted) {
        onPermissionsGiven();
      } else {}
    });

    await requestPermissions();
  }

  void onScanResults(List<ScanResult> results) {
    devices.clear();
    for (ScanResult r in results) {
      print('${r.device.name} ${r.device.id} found! rssi: ${r.rssi}');
      devices.add(r.device);
    }
    notifyListeners();
  }

  Future<void> onPermissionsGiven() async {
    bool bluetoothOn = await _bluetooth.flutterBlue.isOn;
    if (!bluetoothOn) {
      _android.openBluetoothSetting();
    }
    bool locationOn = await _location.requestService();
    print(bluetoothOn && locationOn);
    servicesEnabled.add(bluetoothOn && locationOn);

    if (bluetoothOn && locationOn) {
      // scan();
      print("should be scanning now");
    } else {
      requestPermissions();
    }
  }

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.location,
    ].request();

    print(statuses[Permission.location]);
    print(statuses[Permission.bluetooth]);
    print("both permissions given");
    bool locationPermitted = statuses[Permission.location]?.isGranted ?? false;
    bool bluetoothPermitted =
        statuses[Permission.bluetooth]?.isGranted ?? false;

    permissionsGiven.add(locationPermitted && bluetoothPermitted);
  }

  // Currently not needed, might be removed later
  void initConnectStatus() {
    _bluetooth.selectedDevice.state.listen((state) {
      isConnected = (state == BluetoothDeviceState.connected);
    });
  }

  Future<bool> scan() async {
    try {
      devices.clear();
      notifyListeners();
      await _bluetooth.flutterBlue.startScan(timeout: Duration(seconds: 4));
      print("scan complete");
      return true;
    } catch (e) {
      print("bluetooth not ready or enabled, or location not enabled");
      print(e);
      //_showDialog();
      //alert something
      // TODO: "Notify view of failed scan"

      return false;
    }
  }

  Future<void> connect(BluetoothDevice device) async {
    _bluetooth.selectedDevice = device;
    try {
      await _bluetooth.selectedDevice.connect(autoConnect: false);
      print('connected to address: ${device.id} name: ${device.name}');

      List<BluetoothService> services =
          await _bluetooth.selectedDevice.discoverServices();
      BluetoothService service = services
          .where((service) => (service.uuid == Guid(SERVICE_UUID)))
          .toList()[0];

      // Test code for reading and writing that will be moved later
      for (BluetoothCharacteristic c in service.characteristics) {
        if (c.uuid == Guid(READ_CHAR_UUID)) {
          _bluetooth.readChar = c;
          List<int> value = await c.read();
          print("read: $value from char: $READ_CHAR_UUID");
        }
        if (c.uuid == Guid(WRITE_CHAR_UUID)) {
          _bluetooth.writeChar = c;
          List<int> value = [65];
          await c.write(value);
          print("wrote: $value to char: $WRITE_CHAR_UUID");
        }
      }

      //TODO: change view after successful connection
    } catch (e) {
      print(e);
      print('connection failed to address: ${device.id} name: ${device.name}');
    }
  }
}
