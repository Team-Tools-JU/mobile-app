import 'dart:core';

import 'dart:math';

class PositionEvent {
  num angle; // 180 - (-180)
  int length; //Lenght in mm
  String positionDateTime;
  int sessionID;
  num positionCoord_x;
  num positionCoord_y;

  PositionEvent(num angle, int length, String positionDateTime,
      num positionCoord_x, num positionCoord_y,
      {int sessionID}) {
    this.angle = angle;
    this.length = length;
    this.positionDateTime = positionDateTime;
    this.sessionID = sessionID;
    this.calculateCoordX(angle, length);
    this.calculateCoordY(angle, length);
  }

  void calculateCoordX(num angle, int length) {
    setXCoord((length * cos(angle)).toInt());
  }

  void calculateCoordY(num angle, int lenght) {
    setYCoord(length * sin(angle).toInt());
  }

  int getXCoord() {
    return this.positionCoord_x;
  }

  int getYCoord() {
    return this.positionCoord_y;
  }

  String getpositionDate() {
    return this.positionDateTime;
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
