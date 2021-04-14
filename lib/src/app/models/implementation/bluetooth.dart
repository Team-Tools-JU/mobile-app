import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:typed_data';
import 'package:mobile_app/src/app/models/interfaces/bluetooth.dart';

class Bluetooth implements BluetoothInterface {
  final bluetoothService = FlutterReactiveBle();
  DeviceConnectionState _connectionStatus;

  Bluetooth() {
    bluetoothService.statusStream.listen((status) {});

    bluetoothService.connectedDeviceStream.listen((status) {
      _connectionStatus = status.connectionState;
    });
  }

  @override
  Future<BTDevice> connectedDevice;

  @override
  bool isReady() => (bluetoothService.status == BleStatus.ready);

  @override
  // TODO: implement isConnected
  bool get isConnected =>
      (_connectionStatus == DeviceConnectionState.connected);

  @override
  Future<List<BTDevice>> scan(Duration duration) async {
    List<BTDevice> devices;

    await bluetoothService.scanForDevices(
        withServices: [], scanMode: ScanMode.lowLatency).listen((device) {
      devices.add(BTDevice(device.name, device.id));
    }, onError: () {
      //code for handling error
    }).asFuture();

    return devices;
  }

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
  Future send(Uint8List data) {
    // TODO: implement send
    throw UnimplementedError();
  }

  @override
  Stream<Uint8List> receive() {
    // TODO: implement receive
    throw UnimplementedError();
  }
}
