import 'dart:core';

import 'dart:math';

class PositionEvent {
  num angle; // 180 - (-180)
  int length; //Lenght in mm
  String positionDateTime;
  int sessionID;
  num pos_CoordX;
  num pos_CoordY;
  bool collision;

  PositionEvent(num angle, int length, String positionDateTime, num pos_CoordX,
      num pos_CoordY,
      {int sessionID}) {
    this.angle = angle;
    this.length = length;
    this.positionDateTime = positionDateTime;
    this.sessionID = sessionID;
    this.calculateCoordX(angle, length);
    this.calculateCoordY(angle, length);
    this.collision = collision;
  }

  void calculateCoordX(num angle, int length) {
    setXCoord((length * cos(angle)).toInt());
  }

  void calculateCoordY(num angle, int lenght) {
    setYCoord(length * sin(angle).toInt());
  }

  int getXCoord() {
    return this.pos_CoordX;
  }

  int getYCoord() {
    return this.pos_CoordY;
  }

  String getpositionDate() {
    return this.positionDateTime;
  }

  void setXCoord(int newXCoord) {
    this.pos_CoordX = newXCoord;
  }

  void setYCoord(int newYCoord) {
    this.pos_CoordY = newYCoord;
  }

  void setDate(String newDate) {
    this.positionDateTime = newDate;
  }
}
