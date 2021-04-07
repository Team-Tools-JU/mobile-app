import 'dart:async';

import 'package:stacked/stacked.dart';

class StartViewModel extends BaseViewModel {
  int _counter = 0;

  int get counter => _counter;

  void init() {}

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
