import 'package:android_intent/android_intent.dart';

class AndroidService {
  Future<void> openLocationSetting() async {
    final AndroidIntent intent = new AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    await intent.launch();
  }

  Future<void> openBluetoothSetting() async {
    final AndroidIntent intent = new AndroidIntent(
      action: 'android.settings.BLUETOOTH_SETTINGS',
    );
    await intent.launch();
  }
}
