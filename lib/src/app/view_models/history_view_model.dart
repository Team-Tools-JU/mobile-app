import 'package:mobile_app/database/database.dart';
import 'package:mobile_app/database/position_event.dart';
import 'package:mobile_app/src/app/models/constants/text_constants.dart';
import 'package:mobile_app/src/app/views/history/components/pathPainter.dart';
import 'package:stacked/stacked.dart';

class HistoryViewModel extends BaseViewModel {
  late String _currentSessionDate;
  late List<Session> _sessions;
  bool complete = false;
  List<Session> get sessions => _sessions;

  String get currentSessionDate => _currentSessionDate;

  void init() async {
    _sessions = await Database().getAllSessions();
    _currentSessionDate = _sessions[0].date;
    complete = true;
    notifyListeners();
  }

  setSessionName(String newSession) {
    _currentSessionDate = newSession;
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<PositionEvent> getCurrentSession() {
    List<PositionEvent> hmm = [];
    for (int i = 0; i < sessions.length; i++) {
      if (sessions[i].date == currentSessionDate) {
        return sessions[i].positions;
      }
    }
    return hmm;
  }
}
