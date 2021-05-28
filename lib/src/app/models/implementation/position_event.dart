import 'dart:math';

class Session {
  late String date;
  late List<PositionEvent> positions;

  Session(value) {
    positions = [];
    PositionEvent previousPosition =
        PositionEvent(angle: 0, length: 0, collision: 0);
    positions.add(previousPosition);
    value.forEach((key, value) {
      print("here is the value:");
      print(value);
      PositionEvent position = PositionEvent.fromJson(
          Map<String, Object>.from(value), previousPosition);
      previousPosition = position;
      positions.add(position);
    });
  }

  void setDate(String key) {
    date = key;
  }
}

class PositionEvent {
  PositionEvent? previousPosition;
  int collision;
  double angle; // 180 - (-180)
  int length; //Lenght in mm
  late double pos_CoordX;
  late double pos_CoordY;

  PositionEvent(
      {required this.angle,
      required this.length,
      required this.collision,
      this.previousPosition}) {
    this.calculateCoordX(angle, length);
    this.calculateCoordY(angle, length);
  }

  PositionEvent.fromJson(
      Map<String, Object> json, PositionEvent previousPosition)
      : this(
          collision: int.parse(json['collision'] as String),
          length: int.parse(json['length'] as String),
          angle: double.parse(json['angle'] as String),
          previousPosition: previousPosition,
        );

  void calculateCoordX(num angle, int length) {
    if (previousPosition == null) {
      setXCoord((length * cos((pi / 180) * angle)));
    } else {
      setXCoord(
          (length * cos((pi / 180) * angle)) + previousPosition!.pos_CoordX);
    }
  }

  void calculateCoordY(num angle, int length) {
    if (previousPosition == null) {
      setYCoord((length * sin((pi / 180) * angle)));
    } else {
      setYCoord(
          (length * sin((pi / 180) * angle)) + previousPosition!.pos_CoordY);
    }
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
