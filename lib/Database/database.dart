// Import the CollisionEvent class
import 'dart:html';
import 'dart:js_util';

import 'package:flutter/cupertino.dart';

import 'collisionEventData.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/Database/collisionEventData.dart';

class Database {
  //final dbReference = FirebaseFirestore.instance.collection("collectionPath")
  CollectionReference collisionHistory =
      FirebaseFirestore.instance.collection("collisionHistory");

  Future<void> getAllCollisionEvents() async {
    QuerySnapshot querySnapshot = await collisionHistory.get();
    final allEvents = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allEvents);
  }

  void addCollisionEvent(CollisionEvent collisionEvent) {
    collisionHistory
        .add({
          'coord_x': collisionEvent.collisionCoord_x.toString(),
          'coord_y': collisionEvent.collisionCoord_y.toString(),
          'date': collisionEvent.collisionDate
        })
        .then((value) => print("Collision event added"))
        .catchError((error) => print("Failed to add collision event: $error"));
  }

  void deleteCollisionEvent(CollisionEvent collisionEvent) {
    collisionHistory
        .where('sessionID', isEqualTo: collisionEvent.sessionID)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.delete();
    });
  }

  void updateCollisionEvent(CollisionEvent collisionEvent) {
    collisionHistory
        .doc(collisionEvent.sessionID.toString())
        .update({
          'coord_x': collisionEvent.collisionCoord_x.toString(),
          'coord_y': collisionEvent.collisionCoord_y.toString(),
          'date': collisionEvent.collisionDate.toString()
        })
        .then((value) => print("Collision event updated."))
        .catchError((error) => print("Failed to update event: $error"));
  }
}
