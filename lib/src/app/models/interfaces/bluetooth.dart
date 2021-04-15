import 'dart:typed_data';

abstract class BluetoothInterface {
  BTDevice selectedDevice;

  bool isReady();

  bool get isConnected => false;

  Future<List<BTDevice>> scan(Duration duration);

  Future<bool> connect(BTDevice device);

  Future<void> disconnect();

  Future<dynamic> send(Uint8List data);

  Stream<List<int>> subscribe();
}

class BTDevice {
  final String _name;
  final String _id;

  BTDevice(this._name, this._id);

  String get name => _name;
  String get id => _id;
}
