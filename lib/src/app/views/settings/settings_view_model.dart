import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {

  bool simulationMode;
  bool manualSteering;

  bool get _simulationMode => simulationMode;
  bool get _manualSteering => manualSteering;

  void init() {
    simulationMode = false;
    manualSteering = false;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
