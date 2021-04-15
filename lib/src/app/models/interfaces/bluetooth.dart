import 'dart:typed_data';

abstract class BluetoothInterface {
  late BTDevice selectedDevice;

  bool isReady();

  bool get isConnected => false;

  Future<List<BTDevice>> scan(Duration duration);

  Future<bool> connect(BTDevice device);

  Future<void> disconnect();

  Future<dynamic> send(Uint8List data);

  Stream<List<int>> subscribe();
}

class BTDevice {
  final String? name;
  final String id;

  BTDevice(this.name, this.id);
}
