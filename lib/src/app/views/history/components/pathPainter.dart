import 'package:flutter/material.dart';
import 'package:mobile_app/database/position_event.dart';
import 'dart:math';

import 'package:mobile_app/src/app/view_models/history_view_model.dart';

class PathPainter extends CustomPainter {
  //final List<PositionEvent> positionEvents;
  final HistoryViewModel model;
  const PathPainter(this.model);

/*
  set positions(positions) {
    this.positionEvents = positions;
  }
  */

  //PathPainter({required this.positionEvents});

  @override
  void paint(Canvas canvas, Size size) {
    //these 2 lines should be removed when paint is created with real data
    List<PositionEvent> positionEvents = model.getCurrentSession();

    Paint collisionPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    Paint pathPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Path path = Path();

    PositionEvent origin = positionEvents[0];
    path.moveTo(origin.pos_CoordX, origin.pos_CoordY);
    for (PositionEvent position in positionEvents) {
      path.lineTo(position.pos_CoordX, position.pos_CoordY);

      if (position.collision == 1) {
        canvas.drawCircle(Offset(position.pos_CoordX, position.pos_CoordY), 6,
            collisionPaint);
      }
    }

    //canvas.scale(x_scale, y_scale);
    //This allows us to get the bounds of the path we will paint, don't know how to scale it to fit the canvas..
    Rect bounds = path.getBounds();
    var left = bounds.left;
    var right = bounds.right;
    var top = bounds.top;
    var bottom = bounds.bottom;

    canvas.drawPath(path, pathPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
/*

//TODO: this should be removed once we get real data
  List<PositionEvent> getPositions(int sessionID) {
    final positionEvents = [
      PositionEvent(100, 200, false),
      PositionEvent(-50, 200, true),
      PositionEvent(58, 160, false),
      PositionEvent(-150, 34, false),
      PositionEvent(-160, -200, false),
      PositionEvent(-100, -70, true),
      PositionEvent(-100, -200, false),
    ];

    return positionEvents;
  }
}

//TODO: remove once we get the real class and get the data dynamically
class PositionEvent {
  double positionCoord_x;
  double positionCoord_y;
  bool collision;

  PositionEvent(this.positionCoord_x, this.positionCoord_y, this.collision);

  bool getCollision() {
    return this.collision;
  }

  double getXCoord() {
    return this.positionCoord_x;
  }

  double getYCoord() {
    return this.positionCoord_y;
  }

  void setXCoord(double newXCoord) {
    this.positionCoord_x = newXCoord;
  }

  void setYCoord(double newYCoord) {
    this.positionCoord_y = newYCoord;
  }
}
*/
