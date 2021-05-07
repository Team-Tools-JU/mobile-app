import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

abstract class BluetoothInterface {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  late BluetoothDevice selectedDevice;
  late BluetoothCharacteristic readChar;
  late BluetoothCharacteristic writeChar;
  bool isConnected = false;
  StreamController<bool> isConnectedStream = StreamController<bool>.broadcast();
  StreamController<String> reciever = StreamController<String>.broadcast();

  Future<List<BluetoothDevice>> scan(Duration duration);

  Future<void> connect();

  Future<dynamic> write(String data);

  Future<void> listen();
}
