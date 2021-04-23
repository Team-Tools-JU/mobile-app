import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:mobile_app/src/app/models/implementation/bluetooth_v2.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:mobile_app/src/app/models/implementation/bluetooth_constants.dart';
import 'package:permission_handler/permission_handler.dart';

class ConnectViewModel extends BaseViewModel {
  Bluetooth _bluetooth = GetIt.I<Bluetooth>();
  List<BluetoothDevice> devices = [];

  bool isConnected = false;

  ConnectViewModel() {
    init();
  }

  Future<void> init() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.location,
    ].request();

    print(statuses[Permission.location]);
    print(statuses[Permission.bluetooth]);
    print("both permissions given");

    _bluetooth.flutterBlue.scanResults.listen((results) {
      devices.clear();
      for (ScanResult r in results) {
        print('${r.device.name} ${r.device.id} found! rssi: ${r.rssi}');
        devices.add(r.device);
      }
      notifyListeners();
    });

    scan();
  }

  // Currently not needed, might be removed later
  void initConnectStatus() {
    _bluetooth.selectedDevice.state.listen((state) {
      isConnected = (state == BluetoothDeviceState.connected);
    });
  }

  Future<bool> scan() async {
    try {
      devices.clear();
      notifyListeners();
      await _bluetooth.flutterBlue.startScan(timeout: Duration(seconds: 4));
      print("scan complete");
      return true;
    } catch (e) {
      print("bluetooth not ready or enabled, or location not enabled");
      print(e);
      //_showDialog();
      //alert something
      // TODO: "Notify view of failed scan"

      return false;
    }
  }

  Future<void> connect(BluetoothDevice device) async {
    _bluetooth.selectedDevice = device;
    try {
      await _bluetooth.selectedDevice.connect(autoConnect: false);
      print('connected to address: ${device.id} name: ${device.name}');

      List<BluetoothService> services =
          await _bluetooth.selectedDevice.discoverServices();
      BluetoothService service = services
          .where((service) => (service.uuid == Guid(SERVICE_UUID)))
          .toList()[0];

      // Test code for reading and writing that will be moved later
      for (BluetoothCharacteristic c in service.characteristics) {
        if (c.uuid == Guid(READ_CHAR_UUID)) {
          _bluetooth.readChar = c;
          List<int> value = await c.read();
          print("read: $value from char: $READ_CHAR_UUID");
        }
        if (c.uuid == Guid(WRITE_CHAR_UUID)) {
          _bluetooth.writeChar = c;
          List<int> value = [65];
          await c.write(value);
          print("wrote: $value to char: $WRITE_CHAR_UUID");
        }
      }

      //TODO: change view after successful connection
    } catch (e) {
      print(e);
      print('connection failed to address: ${device.id} name: ${device.name}');
    }
  }
}
