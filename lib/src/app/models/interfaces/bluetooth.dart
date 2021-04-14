import 'dart:typed_data';

abstract class Bluetooth {
  BTDevice connectedDevice;

  bool get isConnected => false;

  Future<bool> isEnabled();

  Future<List<BTDevice>> scan(Duration duration);

  Future<bool> connect();

  Future<void> disconnect();

  Stream<Uint8List> receive();

  Future<dynamic> send(Uint8List data);
}

abstract class BTDevice {
  String name;
  String address;
}
