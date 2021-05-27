import 'package:firebase_database/firebase_database.dart';
import 'package:mobile_app/database/position_event.dart';

class Database {
  final DatabaseReference positionEvents =
      FirebaseDatabase.instance.reference();

  void addPositionEvent(PositionEvent positionEvent) {
    positionEvents.child(positionEvent.toString()).set({
      'angle': positionEvent.angle.toString(),
      'collision': positionEvent.collision.toString(),
      'lenght': positionEvent.length.toString()
    });
  }

  List<String> getAllPositions(String sessionID) {
    List<String> positions = [];
    positionEvents.orderByChild(sessionID).once().then((DataSnapshot snapshot) {
      positions.add(snapshot.value.toString());
    });
    print(positions);
    return positions;
  }

  void getAllSessions() {
    positionEvents.once().then((DataSnapshot dataSnapshot) {
      List<Session> sessions = [];

      if (dataSnapshot.value != null) {
        dataSnapshot.value.forEach((key, value) {
          Session session = Session(key, value);
          session.setDate(key);
          sessions.add(session);
        });
        sessions.forEach((element) {
          print(element.date);
        });
      }
    });
  }
}
