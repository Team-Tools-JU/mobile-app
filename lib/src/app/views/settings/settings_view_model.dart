import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  late bool _simulationMode;
  late bool _manualSteering;

  bool get simulationMode => _simulationMode;
  bool get manualSteering => _manualSteering;

  void init() {
    _simulationMode = false;
    _manualSteering = false;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
