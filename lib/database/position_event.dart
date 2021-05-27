import 'dart:math';
import 'dart:convert';

import 'package:get/get.dart';

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

/*
{2021-05-20-14:33:1621514036: {-Ma8lf0zoWguLDFncMdJ: {collision: 0, length: -20, angle: 70.73}, -Ma8lfiVw63lKPk5odId: {collision: 0, length: 119, angle: 36.06}, -Ma8lfAf8D795YulAqsb: {collision: 0, length: -54, angle: 71.64}, -Ma8ledHPpm-J0XuDYrx: {collision: 0, length: 447, angle: 95.98}, -Ma8ldgeD4BHdt1nUGnb: {collision: 0, length: 898, angle: -43.63}, -Ma8ldmD3JNKoBUlJG-i: {collision: 0, length: -35, angle: -39.26}, -Ma8leoTJ9y7eIykGiFi: {collision: 0, length: -39, angle: 100.11}, -Ma8lfs0LBA4kSZKEBX7: {collision: 0, length: -35, angle: 40.64}}, 2021-05-20-15:02:1621515760: {-Ma8rmpD8JBmH6poooLB: {collision: 0, length: -46, angle: 97.76}, -Ma8rkhTmIVa_oAf-Wib: {collision: 0, length: 1917, angle: -50.34}, -Ma8rkn6jAE5D_45uhEb: {collision: 0, length: -53, angle: -50.68}, -Ma8rlQ_c97h13z7Xice: {collision: 0, length: -52, angle: -4.01}, -Ma8rmfgPk_kxn89V5ys: {collision: 0, length: 252, angle: 96.58}, -Ma8rlpWo3QL_l4zcsmf: {collision: 0, length: 164, angle: 35.82}, -Ma8rlIMv2OMXgY-UtZc: {collision: 0, l


[{2021-05-20-14:33:1621514036: {-Ma8lf0zoWguLDFncMdJ: {collision: 0, length: -20, angle: 70.73}, -Ma8lfiVw63lKPk5odId: {collision: 0, length: 119, angle: 36.06}, -Ma8lfAf8D795YulAqsb: {collision: 0, length: -54, angle: 71.64}, -Ma8ledHPpm-J0XuDYrx: {collision: 0, length: 447, angle: 95.98}, -Ma8ldgeD4BHdt1nUGnb: {collision: 0, length: 898, angle: -43.63}, -Ma8ldmD3JNKoBUlJG-i: {collision: 0, length: -35, angle: -39.26}, -Ma8leoTJ9y7eIykGiFi: {collision: 0, length: -39, angle: 100.11}, -Ma8lfs0LBA4kSZKEBX7: {collision: 0, length: -35, angle: 40.64}}, 2021-05-20-15:02:1621515760: {-Ma8rmpD8JBmH6poooLB: {collision: 0, length: -46, angle: 97.76}, -Ma8rkhTmIVa_oAf-Wib: {collision: 0, length: 1917, angle: -50.34}, -Ma8rkn6jAE5D_45uhEb: {collision: 0, length: -53, angle: -50.68}, -Ma8rlQ_c97h13z7Xice: {collision: 0, length: -52, angle: -4.01}, -Ma8rmfgPk_kxn89V5ys: {collision: 0, length: 252, angle: 96.58}, -Ma8rlpWo3QL_l4zcsmf: {collision: 0, length: 164, angle: 35.82}, -Ma8rlIMv2OMXgY-UtZc: {collision: 0, length:
*/
