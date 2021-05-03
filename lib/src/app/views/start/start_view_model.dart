import 'package:stacked/stacked.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:get_it/get_it.dart';
import 'package:mobile_app/src/app/models/implementation/android_service.dart';
import 'package:mobile_app/src/app/models/implementation/bluetooth_v2.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:location/location.dart' as L;
import 'package:permission_handler/permission_handler.dart';

class StartViewModel extends IndexTrackingViewModel {
  Bluetooth _bluetooth = GetIt.I<Bluetooth>();
  L.Location _location = new L.Location();

  AndroidService _android = GetIt.I<AndroidService>();
  List<BluetoothDevice> devices = [];

  StreamController<bool> servicesEnabled = StreamController<bool>.broadcast();
  StreamController<bool> permissionsGiven = StreamController<bool>.broadcast();

  String bluetoothStatusText = 'default';
  bool isConnected = false;

  String get _bluetoothStatusText => bluetoothStatusText;

  void init() async {
    bluetoothStatusText = 'initialised';
    isConnected = false;
    _bluetooth.flutterBlue.scanResults.listen((results) {
      onScanResults(results);
    });
    notifyListeners();

    permissionsGiven.stream.listen((permitted) {
      if (permitted) {
        onPermissionsGiven();
      }
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
      devices.clear();
      await _bluetooth.scan();
      notifyListeners();
      print("scan complete");
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
      print('connected to address: ${device.id} name: ${device.name}');

      //TODO: change view after successful connection
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
