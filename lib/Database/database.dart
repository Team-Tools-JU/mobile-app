import 'positionEvent.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  //CRUD operations for Collision Event
  CollectionReference collisionHistory =
      FirebaseFirestore.instance.collection("collisionHistory");

  Future<void> getAllCollisionEvents() async {
    QuerySnapshot querySnapshot = await collisionHistory.get();
    final allEvents = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allEvents);
  }

  Future<void> addCollisionEvent(PositionEvent collisionPosition) {
    if (collisionPosition.collision == true) {
      return collisionHistory
          .add({
            //Convert to String before saving
            'coord_x': collisionPosition.pos_CoordX.toString(),
            'coord_y': collisionPosition.pos_CoordY.toString(),
            'date': collisionPosition.positionDateTime
          })
          .then((data) => print("Collision event added"))
          .catchError(
              (error) => print("Failed to add collision event: $error"));
    }
  }

  Future<void> deleteCollisionEvent(PositionEvent collisionPosition) {
    return collisionHistory
        .where('sessionID', isEqualTo: collisionPosition.sessionID)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.delete().catchError(
          (error) => print("Failed to add collision event: $error"));
    });
  }

  Future<void> updateCollisionEvent(PositionEvent collisionPosition) {
    return collisionHistory
        .doc(collisionPosition.sessionID.toString())
        .update({
          'coord_x': collisionPosition.pos_CoordX.toString(),
          'coord_y': collisionPosition.pos_CoordY.toString(),
          'date': collisionPosition.positionDateTime
        })
        .then((value) => print("Collision event updated."))
        .catchError((error) => print("Failed to update event: $error"));
  }

  Future<PositionEvent> getCollisionEventByID(String sessionID) async {
    DocumentReference documentReference = collisionHistory.doc(sessionID);
    PositionEvent retrievedEvent;
    await documentReference.get().then((snapshot) {
      retrievedEvent.setXCoord(snapshot.data()['coord_x'].toInt());
      retrievedEvent.setXCoord(snapshot.data()['coord_y'].toInt());
      retrievedEvent.setDate(snapshot.data()['date']);
    });
    return retrievedEvent;
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////

// CRUD operations for Position Event
  CollectionReference positionHistory =
      FirebaseFirestore.instance.collection("positionHistory");

  Future<void> getAllPositionEvents() async {
    QuerySnapshot querySnapshot = await positionHistory.get();
    final allPositions = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allPositions);
  }

  Future<List> getPositionEventInOrder() async {
    QuerySnapshot querySnapshot =
        await positionHistory.orderBy('sessionID', descending: true).get();
    final positionsInOrder =
        querySnapshot.docs.map((doc) => doc.data()).toList(growable: true);
    return positionsInOrder;
  }

  Future<void> addPositionEvent(PositionEvent positionEvent) {
    return positionHistory
        .add({
          'coord_x': positionEvent.pos_CoordX.toString(),
          'coord_y': positionEvent.pos_CoordY.toString(),
          'dateTime': positionEvent.positionDateTime
        })
        .then((value) => print("Position event added"))
        .catchError((error) => print("Failed to add position event: $error"));
  }

  Future<void> deletePositionEvent(PositionEvent positionEvent) {
    return positionHistory
        .where('sessionID', isEqualTo: positionEvent.sessionID)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference
          .delete()
          .catchError((error) => print("Failed to add position event: $error"));
    });
  }

  //Should not be able to update a position if mower already been there?

}
