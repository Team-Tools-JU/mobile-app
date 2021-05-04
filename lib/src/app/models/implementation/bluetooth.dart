import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:mobile_app/src/app/models/interfaces/bluetooth.dart';
import 'bluetooth_constants.dart';

class Bluetooth implements BluetoothInterface {
  @override
  StreamController<bool> isConnected = StreamController<bool>.broadcast();

  @override
  FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  late BluetoothDevice selectedDevice;

  @override
  late BluetoothCharacteristic readChar;

  @override
  late BluetoothCharacteristic writeChar;

  @override
  StreamController<List<int>> incomingMessages =
      StreamController<List<int>>.broadcast();

  @override
  Future<void> connect() async {
    await selectedDevice.connect(autoConnect: false);

    List<BluetoothService> services = await selectedDevice.discoverServices();
    BluetoothService service = services
        .where((service) => (service.uuid == Guid(SERVICE_UUID)))
        .toList()[0];

    // Test code for reading and writing that will be moved later
    for (BluetoothCharacteristic c in service.characteristics) {
      if (c.uuid == Guid(READ_CHAR_UUID)) {
        readChar = c;
        List<int> value = await c.read();

        print("read: $value from char: $READ_CHAR_UUID");
      }
      if (c.uuid == Guid(WRITE_CHAR_UUID)) {
        writeChar = c;
        List<int> value = [65];
        await c.write(value);
        print("wrote: $value to char: $WRITE_CHAR_UUID");
      }
    }
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

    await flutterBlue.startScan(timeout: duration);

    return foundDevices;
  }

  @override
  Future<void> write(List<int> message) async {
    await writeChar.write(message);
  }

  @override
  void listen() async {
    while (true) {
      Future.delayed(Duration(seconds: 1),
          () async => {incomingMessages.add(await readChar.read())});
    }
  }
}
