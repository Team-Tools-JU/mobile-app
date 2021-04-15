import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:typed_data';
import 'dart:async';
import 'package:mobile_app/src/app/models/interfaces/bluetooth.dart';

class Bluetooth implements BluetoothInterface {
  final _bluetoothService = FlutterReactiveBle();
  late DeviceConnectionState _connectionStatus;
  late StreamSubscription<ConnectionStateUpdate> _connection;

  Bluetooth() {
    //_bluetoothService.statusStream.listen((status) {});

    _bluetoothService.connectedDeviceStream.listen((status) {
      _connectionStatus = status.connectionState;
    });
  }

  @override
  late BTDevice selectedDevice;

  @override
  bool isReady() {
    return (_bluetoothService.status == BleStatus.ready);
  }

  @override
  // TODO: implement isConnected
  bool get isConnected =>
      (_connectionStatus == DeviceConnectionState.connected);

  @override
  Future<List<BTDevice>> scan(Duration duration) async {
    List<BTDevice> devices = [];
    List<String> adresses = [];
    StreamSubscription subscription;

    subscription = _bluetoothService.scanForDevices(
        withServices: [], scanMode: ScanMode.lowLatency).listen((device) {
      String deviceName = device.name != "" ? device.name : "No name";
      if (!adresses.contains(device.id)) {
        adresses.add(device.id);
        devices.add(BTDevice(deviceName, device.id));
      }
    }, onError: (error) {
      print("scan error" + error);
      //code for handling error
    });

    await Future.delayed(duration, () => {subscription.cancel()});
    print(devices);
    return devices.toSet().toList();
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
        serviceId: Uuid([0x1200]),
        characteristicId: Uuid([0x1200]),
        deviceId: selectedDevice.id);
    await _bluetoothService
        .writeCharacteristicWithResponse(characteristic, value: [0x00]);
  }

  @override
  Stream<List<int>> subscribe() {
    return _bluetoothService.subscribeToCharacteristic(QualifiedCharacteristic(
        serviceId: Uuid([0x1200]),
        characteristicId: Uuid([0x1200]),
        deviceId: selectedDevice.id));
  }
}
