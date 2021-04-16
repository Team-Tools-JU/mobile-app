import 'dart:async';
import 'package:mobile_app/src/app/models/implementation/bluetooth.dart';
import 'package:mobile_app/src/app/models/interfaces/bluetooth.dart';
import 'package:stacked/stacked.dart';

class ConnectViewModel extends BaseViewModel {
  List<BTDevice> devices = [];
  final Bluetooth _bluetooth = Bluetooth();
  final Duration _scanDuration = Duration(seconds: 5);

  Future<bool> scan() async {
    try {
      bool ready = _bluetooth.isReady();
      if (ready) {
        devices.clear();
        notifyListeners();
        devices = await _bluetooth.scan(_scanDuration);
        print("scan complete");

        notifyListeners();
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<void> connect(BTDevice device) async {
    await _bluetooth.connect(device);
    if (_bluetooth.isConnected) {
      print('connected to address: ${device.id} name: ${device.name}');
    } else {
      print('connection failed to address: ${device.id} name: ${device.name}');
    }
  }
}
