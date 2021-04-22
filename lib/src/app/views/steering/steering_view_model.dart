import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SteeringViewModel extends BaseViewModel {

  bool _simulationMode = false;
  bool _manualSteering = false;

  bool get simulationMode => _simulationMode;

  bool get manualSteering => _manualSteering;

  void init() {}


  @override
  void dispose() {
    super.dispose();
  }
}
