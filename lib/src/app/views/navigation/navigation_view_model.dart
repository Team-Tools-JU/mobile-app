import 'package:stacked/stacked.dart';

class NavigationViewModel extends IndexTrackingViewModel {

  String bluetoothStatusText = 'default';
  bool isConnected = false;

  String get _bluetoothStatusText => bluetoothStatusText;

  String updateBluetoothStatus() {
    if (isConnected) {
      bluetoothStatusText = 'Connected!';
    } else {
      bluetoothStatusText = 'Not connected!';
    }
    return _bluetoothStatusText;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
