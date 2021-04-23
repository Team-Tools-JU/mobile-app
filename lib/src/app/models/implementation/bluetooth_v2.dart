import 'package:flutter_blue/flutter_blue.dart';
import 'package:mobile_app/src/app/models/implementation/bluetooth_constants.dart';

class Bluetooth {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  late BluetoothDevice selectedDevice;
  late BluetoothCharacteristic readChar;
  late BluetoothCharacteristic writeChar;
}
