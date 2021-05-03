import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

import 'bluetooth_constants.dart';

class Bluetooth {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  late BluetoothDevice selectedDevice;
  late BluetoothCharacteristic readChar;
  late BluetoothCharacteristic writeChar;
  StreamController<List<int>> incomingMessages =
      StreamController<List<int>>.broadcast();

  Future<void> connect() async {
    await selectedDevice.connect(autoConnect: false);
    print(
        'connected to address: ${selectedDevice.id} name: ${selectedDevice.name}');

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

  Future<void> scan() async {
    await flutterBlue.startScan(timeout: Duration(seconds: 4));
    print("scan complete");
  }

  Future<void> write(List<int> message) async {
    await writeChar.write(message);
  }

  void listen() async {
    while (true) {
      Future.delayed(Duration(seconds: 1),
          () async => {incomingMessages.add(await readChar.read())});
    }
  }
}
