import 'dart:async';

class SettingsController {
  StreamController<bool> steeringEnabled = StreamController<bool>.broadcast();
}
