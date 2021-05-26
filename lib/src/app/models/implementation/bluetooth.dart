import 'dart:async';
import 'dart:convert';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:mobile_app/src/app/models/interfaces/bluetooth.dart';
import '../constants/bluetooth_constants.dart';

class Bluetooth implements BluetoothInterface {
  @override
  StreamController<bool> isConnectedStream = StreamController<bool>.broadcast();

  @override
  FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  late BluetoothDevice selectedDevice;

  @override
  late BluetoothCharacteristic readChar;

  @override
  late BluetoothCharacteristic writeChar;

  @override
  StreamController<String> reciever = StreamController<String>.broadcast();

  bool _isScanning = false;

  bool isConnected = false;

  @override
  Future<void> connect() async {
    await selectedDevice.connect(
        timeout: Duration(seconds: 10), autoConnect: false);

    List<BluetoothService> services = await selectedDevice.discoverServices();

    BluetoothService readService = services
        .where((service) => (service.uuid == Guid(READ_SERVICE_UUID)))
        .first;

    BluetoothService writeService = services
        .where((service) => (service.uuid == Guid(WRITE_SERVICE_UUID)))
        .first;

    writeChar = writeService.characteristics
        .where((c) => (c.uuid == Guid(WRITE_CHAR_UUID)))
        .first;
    readChar = readService.characteristics
        .where((c) => (c.uuid == Guid(READ_CHAR_UUID)))
        .first;
  }

  @override
  Future<void> disconnect() async {
    await selectedDevice.disconnect();
  }

  @override
  Future<List<BluetoothDevice>> scan(Duration duration) async {
    List<BluetoothDevice> foundDevices = [];

    flutterBlue.scanResults.listen((results) {
      foundDevices.clear();
      results.forEach((result) {
        foundDevices.add(result.device);
      });
    });

    flutterBlue.isScanning.listen((isScanning) {
      _isScanning = isScanning;
    });

    if (!_isScanning) {
      await flutterBlue.startScan(timeout: duration);
    }
    return foundDevices;
  }

  @override
  Future<void> write(String message) async {
    print("writing $message");
    await writeChar.write(utf8.encode(message));
  }

  @override
  Future<void> listen() async {
    readChar.setNotifyValue(true);
    readChar.value.listen((message) {
      print("MESSAGE: ${ascii.decode(message)}");
      reciever.add(ascii.decode(message));
    });
  }
}
