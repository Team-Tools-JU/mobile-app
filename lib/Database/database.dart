// Import the CollisionEvent class
import 'dart:html';
import 'dart:js_util';

import 'package:flutter/cupertino.dart';

import 'collisionEventData.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/Database/collisionEventData.dart';

class Database {
  CollectionReference collisionHistory =
      FirebaseFirestore.instance.collection("collisionHistory");

  CollectionReference positionHistory =
      FirebaseFirestore.instance.collection("positionHistory");

  Future<void> getAllCollisionEvents() async {
    QuerySnapshot querySnapshot = await collisionHistory.get();
    final allEvents = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allEvents);
  }

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

  Future<void> addCollisionEvent(CollisionEvent collisionEvent) {
    return collisionHistory
        .add({
          'coord_x': collisionEvent.collisionCoord_x.toString(),
          'coord_y': collisionEvent.collisionCoord_y.toString(),
          'date': collisionEvent.collisionDate
        })
        .then((value) => print("Collision event added"))
        .catchError((error) => print("Failed to add collision event: $error"));
  }

  // void deleteCollisionEvent(CollisionEvent collisionEvent) {
  //   collisionHistory
  //       .where('sessionID', isEqualTo: collisionEvent.sessionID)
  //       .get()
  //       .then((snapshot) {
  //     snapshot.docs.first.reference.delete();
  //   });
  // }

  Future<void> deleteCollisionEvent(CollisionEvent collisionEvent) {
    return collisionHistory
        .where('sessionID', isEqualTo: collisionEvent.sessionID)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.delete().catchError(
          (error) => print("Failed to add collision event: $error"));
    });
  }

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

  Future<void> updateCollisionEvent(CollisionEvent collisionEvent) {
    return collisionHistory
        .doc(collisionEvent.sessionID)
        .update({
          'coord_x': collisionEvent.collisionCoord_x.toString(),
          'coord_y': collisionEvent.collisionCoord_y.toString(),
          'date': collisionEvent.collisionDate.toString()
        })
        .then((value) => print("Collision event updated."))
        .catchError((error) => print("Failed to update event: $error"));
  }

  Future<CollisionEvent> getCollisionEventByID(String sessionID) async {
    DocumentReference documentReference = collisionHistory.doc(sessionID);
    CollisionEvent retrievedEvent;
    await documentReference.get().then((snapshot) {
      retrievedEvent.setXCoord(snapshot.data()['coord_x']);
      retrievedEvent.setYCoord(snapshot.data()['coord_y']);
      retrievedEvent..setDate(snapshot.data()['date']);
    });
    return retrievedEvent;
  }
}
