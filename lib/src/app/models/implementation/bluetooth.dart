import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:mobile_app/src/app/models/interfaces/bluetooth.dart';

class Bluetooth implements BluetoothInterface {
  final _bluetoothService = FlutterReactiveBle();
  DeviceConnectionState _connectionStatus;
  StreamSubscription<ConnectionStateUpdate> _connection;

  Bluetooth() {
    //_bluetoothService.statusStream.listen((status) {});

    _bluetoothService.connectedDeviceStream.listen((status) {
      _connectionStatus = status.connectionState;
    });
  }

  @override
  BTDevice selectedDevice;

  @override
  bool isReady() => (_bluetoothService.status == BleStatus.ready);

  @override
  // TODO: implement isConnected
  bool get isConnected =>
      (_connectionStatus == DeviceConnectionState.connected);

  @override
  Future<List<BTDevice>> scan(Duration duration) async {
    List<BTDevice> devices;

    await _bluetoothService.scanForDevices(
        withServices: [], scanMode: ScanMode.lowLatency).listen((device) {
      devices.add(BTDevice(device.name, device.id));
    }, onError: () {
      //code for handling error
    }).asFuture();

    return devices;
  }

  @override
  Future<bool> connect(BTDevice device) async {
    selectedDevice = device;
    await _bluetoothService
        .connectToDevice(
            id: selectedDevice.id,
            connectionTimeout: const Duration(seconds: 2))
        .listen((connectionState) {}, onError: (Object error) {
      // Handle a possible error
    }).asFuture();

    return isConnected;
  }

  @override
  Future<void> disconnect() async {
    await _connection.cancel();
  }

  @override
  Future send(Uint8List data) async {
    final characteristic = QualifiedCharacteristic(
        serviceId: null, characteristicId: null, deviceId: selectedDevice.id);
    await _bluetoothService
        .writeCharacteristicWithResponse(characteristic, value: [0x00]);
  }

  @override
  Stream<List<int>> subscribe() {
    return _bluetoothService.subscribeToCharacteristic(null);
  }
}
