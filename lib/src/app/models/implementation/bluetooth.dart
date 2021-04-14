import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:typed_data';

import 'package:mobile_app/src/app/models/interfaces/bluetooth.dart';

class BluetoothDevice implements Bluetooth {
  final bluetoothService = FlutterReactiveBle();

  @override
  BTDevice connectedDevice;

  @override
  Future<bool> connect() {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  Future<void> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  // TODO: implement isConnected
  bool get isConnected => throw UnimplementedError();

  @override
  Future<bool> isEnabled() {
    // TODO: implement isEnabled
    throw UnimplementedError();
  }

  @override
  Stream<Uint8List> receive() {
    // TODO: implement receive
    throw UnimplementedError();
  }

  @override
  Future<List<BTDevice>> scan(Duration duration) {
    // TODO: implement scan
    throw UnimplementedError();
  }

  @override
  Future send(Uint8List data) {
    // TODO: implement send
    throw UnimplementedError();
  }
}
