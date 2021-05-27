import 'package:get_it/get_it.dart';
import 'package:mobile_app/src/app/models/implementation/database.dart';
import 'package:mobile_app/src/app/models/implementation/position_event.dart';
import 'package:mobile_app/src/app/models/constants/text_constants.dart';
import 'package:stacked/stacked.dart';

class HistoryViewModel extends BaseViewModel {
  late String _currentSession;
  late List<Session> _sessions;
  int _currentIndex = 0;
  bool complete = false;

  String get currentSession => _currentSession;

  void init() async {
    _currentSession = SESSION_1_LABEL;
    _sessions = await GetIt.I<Database>().getAllSessions();
    complete = true;
    notifyListeners();
  }

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
    return _sessions.length > _currentIndex
        ? _sessions[_currentIndex].positions
        : [];
  }
}
