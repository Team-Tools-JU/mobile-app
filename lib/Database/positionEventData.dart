import 'dart:core';

class PositionEvent {
  int positionCoord_x;
  int positionCoord_y;
  String positionDateTime;
  String sessionID;

  PositionEvent(
      this.positionCoord_x, this.positionCoord_y, this.positionDateTime,
      {this.sessionID});

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
