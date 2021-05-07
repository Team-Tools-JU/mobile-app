import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HistoryViewModel extends BaseViewModel {

  late String _firstSession;
  String get firstSession => _firstSession;

  void init() {

    _firstSession = 'Session one';
  }

  setSessionName(String newSession) {

    _firstSession = newSession;
  }

  @override
  void dispose() {
    super.dispose();
  }
}