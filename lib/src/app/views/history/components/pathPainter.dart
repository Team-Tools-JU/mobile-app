import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/models/implementation/position_event.dart';
import 'package:mobile_app/src/app/view_models/history_view_model.dart';

class PathPainter extends CustomPainter {
  final HistoryViewModel model;
  const PathPainter(this.model);

  @override
  void paint(Canvas canvas, Size size) {
    List<PositionEvent> positionEvents = model.getCurrentSession();

    Paint collisionPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    Paint pathPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Path path = Path();

    double scale = 0.3;

    if (positionEvents.isNotEmpty) {
      PositionEvent origin = positionEvents[0];
      path.moveTo(origin.pos_CoordY * scale, origin.pos_CoordX * scale);
      for (PositionEvent position in positionEvents) {
        path.lineTo(position.pos_CoordY * scale, position.pos_CoordX * scale);

        if (position.collision == 1) {
          canvas.drawCircle(
              Offset(position.pos_CoordY * scale, position.pos_CoordX * scale),
              6,
              collisionPaint);
        }
      }

      canvas.drawPath(path, pathPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
