import 'dart:async';

import 'package:mobile_app/src/app/models/implementation/bluetooth.dart';
import 'package:mobile_app/src/app/models/interfaces/bluetooth.dart';
import 'package:stacked/stacked.dart';

class ConnectViewModel extends BaseViewModel {
  List<BTDevice> devices = [];
  Bluetooth _bluetooth = Bluetooth();
  final Duration _scanDuration = Duration(seconds: 5);

  Future<bool> scan() async {
    try {
      bool ready = _bluetooth.isReady();
      if (ready) {
        devices.clear();
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
    print("connected");
  }
}
