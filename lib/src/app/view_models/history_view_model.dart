import 'package:mobile_app/database/database.dart';
import 'package:mobile_app/database/position_event.dart';
import 'package:mobile_app/src/app/models/constants/text_constants.dart';
import 'package:mobile_app/src/app/views/history/components/pathPainter.dart';
import 'package:stacked/stacked.dart';

class HistoryViewModel extends BaseViewModel {
  late String _currentSession;
  int _currentIndex = 0;
  late List<Session> _sessions;
  bool complete = false;
  String get currentSession => _currentSession;

  void init() async {
    _currentSession = SESSION_1_LABEL;
    _sessions = await Database().getAllSessions();
    complete = true;
    notifyListeners();
  }

  // Future<void> getData() async {
  //   _sessions = await Database().getAllSessions();
  // }

  setSessionName(String newSession) {
    _currentSession = newSession;
    setIndex();
  }

  setIndex() {
    switch (_currentSession) {
      case SESSION_1_LABEL:
        _currentIndex = 0;
        break;
      case SESSION_2_LABEL:
        _currentIndex = 1;
        break;
      case SESSION_3_LABEL:
        _currentIndex = 2;
        break;
      case SESSION_4_LABEL:
        _currentIndex = 3;
        break;
      default:
        _currentIndex = 0;
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<PositionEvent> getCurrentSession() {
    return _sessions[_currentIndex].positions;
  }
}
