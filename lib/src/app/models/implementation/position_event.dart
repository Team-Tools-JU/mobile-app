import 'dart:math';

class Session {
  late String date;
  late List<PositionEvent> positions;

  Session(value) {
    positions = [];
    value.forEach((key, value) {
      PositionEvent position =
          PositionEvent.fromJson(Map<String, Object>.from(value));
      positions.add(position);
    });
  }

  void setDate(String key) {
    date = key;
  }
}

class PositionEvent {
  int collision;
  double angle; // 180 - (-180)
  int length; //Lenght in mm
  late double pos_CoordX;
  late double pos_CoordY;

  PositionEvent(
      {required this.angle, required this.length, required this.collision}) {
    this.calculateCoordX(angle, length);
    this.calculateCoordY(angle, length);
  }

  PositionEvent.fromJson(Map<String, Object> json)
      : this(
          collision: int.parse(json['collision'] as String),
          length: int.parse(json['length'] as String),
          angle: double.parse(json['angle'] as String),
        );

  void calculateCoordX(num angle, int length) {
    setXCoord((length * cos(angle)));
  }

  void calculateCoordY(num angle, int length) {
    setYCoord((length * sin(angle)));
  }

  num getXCoord() {
    return this.pos_CoordX;
  }

  num getYCoord() {
    return this.pos_CoordY;
  }

  void setXCoord(double newXCoord) {
    this.pos_CoordX = newXCoord;
  }

  void setYCoord(double newYCoord) {
    this.pos_CoordY = newYCoord;
  }
}
