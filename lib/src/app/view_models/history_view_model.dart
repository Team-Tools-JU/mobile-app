import 'package:mobile_app/src/app/models/constants/text_constants.dart';
import 'package:stacked/stacked.dart';

class HistoryViewModel extends BaseViewModel {
  late String _firstSession;
  String get firstSession => _firstSession;

  void init() {
    _firstSession = SESSION_1_LABEL;
  }

  setSessionName(String newSession) {
    _firstSession = newSession;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
