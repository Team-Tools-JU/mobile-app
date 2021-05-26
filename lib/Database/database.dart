import 'positionEvent.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_database/firebase_database.dart';

class Database {
  final dbRef = FirebaseDatabase.instance.reference();

  void addPositionEvent(PositionEvent positionEvent) {
    dbRef.child(positionEvent.sessionID.toString()).set({
      'angle': positionEvent.angle.toString(),
      'collision': positionEvent.collision.toString(),
      'lenght': positionEvent.length.toString()
    });
  }

  List<String> getAllPositions(String sessionID) {
    List<String> positions;
    dbRef.orderByChild(sessionID).once().then((DataSnapshot snapshot) {
      positions.add(snapshot.value.toString());
    });
    return positions;
  }

  void deletePositionEvent(String sessionID) {
    dbRef.child(sessionID).remove();
  }

  void addCollisionEvent(PositionEvent collisionPosition) {
    if (collisionPosition.collision == true) {
      dbRef.push().set({
        'collisionPositionX': collisionPosition.pos_CoordX.toString(),
        'collisionPositionY': collisionPosition.pos_CoordY.toString(),
        'collisionSession': collisionPosition.positionDateTime.toString()
      });
    } else
      print("A collision has not occured in this position.");
  }

  List<String> getAllCollisionEvents() {
    List<String> collisions;
    dbRef.orderByKey().once().then((DataSnapshot snapshot) {
      collisions.add(snapshot.value.toString());
    });
    return collisions;
  }

  void deleteCollisionEvent(String sessionID) {
    dbRef.child(sessionID).remove();
  }
}

/////////////////////////////////////////////////////////////////////////
//   Future<void> getAllCollisionEvents() async {
//     QuerySnapshot querySnapshot = await collisionHistory.get();
//     final allEvents = querySnapshot.docs.map((doc) => doc.data()).toList();
//     print(allEvents);
//   }

//   Future<void> deleteCollisionEvent(PositionEvent collisionPosition) {
//     return collisionHistory
//         .where('sessionID', isEqualTo: collisionPosition.sessionID)
//         .get()
//         .then((snapshot) {
//       snapshot.docs.first.reference.delete().catchError(
//           (error) => print("Failed to add collision event: $error"));
//     });
//   }

//   Future<void> updateCollisionEvent(PositionEvent collisionPosition) {
//     return collisionHistory
//         .doc(collisionPosition.sessionID.toString())
//         .update({
//           'coord_x': collisionPosition.pos_CoordX.toString(),
//           'coord_y': collisionPosition.pos_CoordY.toString(),
//           'date': collisionPosition.positionDateTime
//         })
//         .then((value) => print("Collision event updated."))
//         .catchError((error) => print("Failed to update event: $error"));
//   }

//   Future<PositionEvent> getCollisionEventByID(String sessionID) async {
//     DocumentReference documentReference = collisionHistory.doc(sessionID);
//     PositionEvent retrievedEvent;
//     await documentReference.get().then((snapshot) {
//       retrievedEvent.setXCoord(snapshot.data()['coord_x'].toInt());
//       retrievedEvent.setXCoord(snapshot.data()['coord_y'].toInt());
//       retrievedEvent.setDate(snapshot.data()['date']);
//     });
//     return retrievedEvent;
//   }

// ////////////////////////////////////////////////////////////////////////////////////////////////////////////

// // CRUD operations for Position Event
//   CollectionReference positionHistory =
//       FirebaseFirestore.instance.collection("positionHistory");

//   Future<void> getAllPositionEvents() async {
//     QuerySnapshot querySnapshot = await positionHistory.get();
//     final allPositions = querySnapshot.docs.map((doc) => doc.data()).toList();
//     print(allPositions);
//   }

//   Future<List> getPositionEventInOrder() async {
//     QuerySnapshot querySnapshot =
//         await positionHistory.orderBy('sessionID', descending: true).get();
//     final positionsInOrder =
//         querySnapshot.docs.map((doc) => doc.data()).toList(growable: true);
//     return positionsInOrder;
//   }

//   Future<void> addPositionEvent(PositionEvent positionEvent) {
//     return positionHistory
//         .add({
//           'coord_x': positionEvent.pos_CoordX.toString(),
//           'coord_y': positionEvent.pos_CoordY.toString(),
//           'dateTime': positionEvent.positionDateTime
//         })
//         .then((value) => print("Position event added"))
//         .catchError((error) => print("Failed to add position event: $error"));
//   }

//   Future<void> deletePositionEvent(PositionEvent positionEvent) {
//     return positionHistory
//         .where('sessionID', isEqualTo: positionEvent.sessionID)
//         .get()
//         .then((snapshot) {
//       snapshot.docs.first.reference
//           .delete()
//           .catchError((error) => print("Failed to add position event: $error"));
//     });
//   }

//   //Should not be able to update a position if mower already been there?

// }
