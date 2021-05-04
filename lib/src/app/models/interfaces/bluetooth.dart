import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

abstract class BluetoothInterface {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  late BluetoothDevice selectedDevice;
  late BluetoothCharacteristic readChar;
  late BluetoothCharacteristic writeChar;
  StreamController<bool> isConnected = StreamController<bool>.broadcast();
  StreamController<List<int>> incomingMessages =
      StreamController<List<int>>.broadcast();

  Future<List<BluetoothDevice>> scan(Duration duration);

  Future<void> connect();

  Future<dynamic> write(List<int> data);

  void listen();
}
