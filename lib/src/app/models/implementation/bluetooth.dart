import 'dart:async';
import 'dart:convert';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:mobile_app/src/app/models/interfaces/bluetooth.dart';
import 'bluetooth_constants.dart';

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
    BluetoothService service = services
        .where((service) => (service.uuid == Guid(SERVICE_UUID)))
        .toList()[0];

    // Test code for reading and writing that will be moved later
    for (BluetoothCharacteristic c in service.characteristics) {
      if (c.uuid == Guid(WRITE_CHAR_UUID)) {
        print(c.uuid);
        writeChar = c;
        readChar = c;
        // await write("AR");
      }
    }
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
    await writeChar.write(utf8.encode(message));
  }

  @override
  Future<void> listen() async {
    print(readChar.properties);
    readChar.value.listen((msg) {
      print("MESSAGE: $msg");
      reciever.add(utf8.decode(msg));
    });
  }
}
