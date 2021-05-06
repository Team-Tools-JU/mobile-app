import 'dart:core';

class CollisionEvent {
  int collisionCoord_x;
  int collisionCoord_y;
  String collisionDate;
  String sessionID; //Session durring which this collision occurred

  CollisionEvent(
      this.collisionCoord_x, this.collisionCoord_y, this.collisionDate,
      {this.sessionID});

  int getXCoord() {
    return this.collisionCoord_x;
  }

  int getYCoord() {
    return this.collisionCoord_y;
  }

  String getCollisionDate() {
    return this.collisionDate;
  }

  void setXCoord(int newXCoord) {
    this.collisionCoord_x = newXCoord;
  }

  void setYCoord(int newYCoord) {
    this.collisionCoord_y = newYCoord;
  }

  CollisionEvent updateCollisionEvent(
      int newXCoord, int newYCoord, String newCollisionDate) {
    return CollisionEvent(
      this.collisionCoord_x = newXCoord,
      this.collisionCoord_y = newYCoord,
      this.collisionDate = newCollisionDate,
    );
  }
}
