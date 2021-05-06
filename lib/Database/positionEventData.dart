import 'dart:core';

import 'dart:ffi';

class PositionEvent {
  Float direction; // 180 - (-180)
  int length; //Lenght in mm
  String positionDateTime;
  int sessionID;
  int positionCoord_x;
  int positionCoord_y;

  PositionEvent(this.direction, this.length, this.positionDateTime,
      {this.positionCoord_x, this.positionCoord_y, this.sessionID});

  int getXCoord() {
    return this.positionCoord_x;
  }

  int getYCoord() {
    return this.positionCoord_y;
  }

  String getpositionDate() {
    return this.positionDateTime;
  }

  void calculateCoord(Float direction, int length) {
    int newX, newY;.ökjö
  }

  void setXCoord(int newXCoord) {
    this.positionCoord_x = newXCoord;
  }

  void setYCoord(int newYCoord) {
    this.positionCoord_y = newYCoord;
  }

  void setDate(String newDate) {
    this.positionDateTime = newDate;
  }
}
