import 'dart:core';

import 'package:mobile_app/Database/positionEventData.dart';

class CollisionEvent {
  PositionEvent collisionPosition;
  String collisionDate;
  int sessionID; //Session durring which this collision occurred, must be an int and ascending

  // int collisionCoord_x;
  // int collisionCoord_y;

  CollisionEvent(this.collisionPosition, this.collisionDate, {this.sessionID});

  String getCollisionDate() {
    return this.collisionDate;
  }

  PositionEvent getCollisionPosition(String sessionID) {
    return this.collisionPosition;
  }

  void setCollisionPos(PositionEvent newCollisionPos) {
    this.collisionPosition = newCollisionPos;
  }

  void setDate(String newDate) {
    this.collisionDate = newDate; //Can't we use the position date&time?
  }

  CollisionEvent updateCollisionEvent(
      PositionEvent newCollisionPos, String newCollisionTime) {
    return CollisionEvent(newCollisionPos, newCollisionTime);
  }

  // int getXCoord() {
  //   return this.collisionCoord_x;
  // }

  // int getYCoord() {
  //   return this.collisionCoord_y;
  // }

  // void setXCoord(int newXCoord) {
  //   this.collisionCoord_x = newXCoord;
  // }

  // void setYCoord(int newYCoord) {
  //   this.collisionCoord_y = newYCoord;
  // }
}
