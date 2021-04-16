import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class StartViewModel extends ChangeNotifier {

  String _bluetoothStatusText = 'default';
  bool _isConnected = false;

  String get bluetoothStatusText => _bluetoothStatusText;

  void init() {
    _bluetoothStatusText = 'initialised';
    _isConnected = false;
    notifyListeners();
  }

  String updateBluetoothStatus() {
    if (_isConnected) {
      _bluetoothStatusText = 'Connected!';
    } else {
      _bluetoothStatusText = 'Not connected!';
    }
    notifyListeners();
    return _bluetoothStatusText;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
