import 'dart:typed_data';

abstract class BluetoothInterface {
  Future<BTDevice> connectedDevice;

  bool isReady();

  bool get isConnected => false;

  Future<List<BTDevice>> scan(Duration duration);

  Future<bool> connect();

  Future<void> disconnect();

  Future<dynamic> send(Uint8List data);

  Stream<Uint8List> receive();
}

class BTDevice {
  final String _name;
  final String _id;

  BTDevice(this._name, this._id);

  String get name => _name;
  String get id => _id;
}
