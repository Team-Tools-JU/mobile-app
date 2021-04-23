import 'package:stacked/stacked.dart';

class StartViewModel extends IndexTrackingViewModel {

  String bluetoothStatusText = 'default';
  bool isConnected = false;

  String get _bluetoothStatusText => bluetoothStatusText;

  void init() {
    bluetoothStatusText = 'initialised';
    isConnected = false;
    notifyListeners();
  }

  String updateBluetoothStatus() {
    if (isConnected) {
      bluetoothStatusText = 'Connected!';
    } else {
      bluetoothStatusText = 'Not connected!';
    }
    notifyListeners();
    return _bluetoothStatusText;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
