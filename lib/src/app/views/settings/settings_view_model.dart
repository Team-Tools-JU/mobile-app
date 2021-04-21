import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel {

  bool _simulationMode = false;
  bool _manuellSteering = false;

  bool get simulationMode => _simulationMode;

  bool get manuellSteering => _manuellSteering;

  void init() {}


  @override
  void dispose() {
    super.dispose();
  }
}
