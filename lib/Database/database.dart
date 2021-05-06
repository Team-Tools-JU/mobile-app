import 'collisionEventData.dart';
import 'positionEventData.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/Database/collisionEventData.dart';

class Database {
  //CRUD operations for Collision Event
  CollectionReference collisionHistory =
      FirebaseFirestore.instance.collection("collisionHistory");

  Future<void> getAllCollisionEvents() async {
    QuerySnapshot querySnapshot = await collisionHistory.get();
    final allEvents = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allEvents);
  }

  Future<void> addCollisionEvent(CollisionEvent collisionEvent) {
    return collisionHistory
        .add({
          //Convert to String before saving
          'coord_x':
              collisionEvent.collisionPosition.positionCoord_x.toString(),
          'coord_y':
              collisionEvent.collisionPosition.positionCoord_y.toString(),
          'date': collisionEvent.collisionDate
        })
        .then((data) => print("Collision event added"))
        .catchError((error) => print("Failed to add collision event: $error"));
  }

  Future<void> deleteCollisionEvent(CollisionEvent collisionEvent) {
    return collisionHistory
        .where('sessionID', isEqualTo: collisionEvent.sessionID)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.delete().catchError(
          (error) => print("Failed to add collision event: $error"));
    });
  }

  Future<void> updateCollisionEvent(CollisionEvent collisionEvent) {
    return collisionHistory
        .doc(collisionEvent.sessionID.toString())
        .update({
          'coord_x':
              collisionEvent.collisionPosition.positionCoord_x.toString(),
          'coord_y':
              collisionEvent.collisionPosition.positionCoord_y.toString(),
          'date': collisionEvent.collisionDate
        })
        .then((value) => print("Collision event updated."))
        .catchError((error) => print("Failed to update event: $error"));
  }

  Future<CollisionEvent> getCollisionEventByID(String sessionID) async {
    DocumentReference documentReference = collisionHistory.doc(sessionID);
    CollisionEvent retrievedEvent;
    await documentReference.get().then((snapshot) {
      retrievedEvent.collisionPosition
          .setXCoord(snapshot.data()['coord_x'].toInt());
      retrievedEvent.collisionPosition
          .setXCoord(snapshot.data()['coord_y'].toInt());
      retrievedEvent.collisionPosition.setDate(snapshot.data()['date']);
    });
    return retrievedEvent;
  }

  // void deleteCollisionEvent(CollisionEvent collisionEvent) {
  //   collisionHistory
  //       .where('sessionID', isEqualTo: collisionEvent.sessionID)
  //       .get()
  //       .then((snapshot) {
  //     snapshot.docs.first.reference.delete();
  //   });
  // }

  // void addCollisionEvent(CollisionEvent collisionEvent) {
  //   collisionHistory
  //       .add({
  //         'coord_x': collisionEvent.collisionCoord_x.toString(),
  //         'coord_y': collisionEvent.collisionCoord_y.toString(),
  //         'date': collisionEvent.collisionDate
  //       })
  //       .then((value) => print("Collision event added"))
  //       .catchError((error) => print("Failed to add collision event: $error"));
  // }

  // void updateCollisionEvent(CollisionEvent collisionEvent) {
  //   collisionHistory
  //       .doc(collisionEvent.sessionID.toString())
  //       .update({
  //         'coord_x': collisionEvent.collisionCoord_x.toString(),
  //         'coord_y': collisionEvent.collisionCoord_y.toString(),
  //         'date': collisionEvent.collisionDate.toString()
  //       })
  //       .then((value) => print("Collision event updated."))
  //       .catchError((error) => print("Failed to update event: $error"));
  // }

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
          'coord_x': positionEvent.positionCoord_x.toString(),
          'coord_y': positionEvent.positionCoord_y.toString(),
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
