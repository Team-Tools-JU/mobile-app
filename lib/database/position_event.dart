import 'dart:math';

class PositionEvent {
  num angle; // 180 - (-180)
  int length; //Lenght in mm
  String positionDateTime;
  int sessionID;
  late num pos_CoordX;
  late num pos_CoordY;
  bool collision;

  PositionEvent(
      {required this.angle,
      required this.length,
      required this.positionDateTime,
      required this.sessionID,
      required this.collision}) {
    this.calculateCoordX(angle, length);
    this.calculateCoordY(angle, length);
  }

  void calculateCoordX(num angle, int length) {
    setXCoord((length * cos(angle)).toInt());
  }

  void calculateCoordY(num angle, int length) {
    setYCoord(length * sin(angle).toInt());
  }

  num getXCoord() {
    return this.pos_CoordX;
  }

  num getYCoord() {
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
