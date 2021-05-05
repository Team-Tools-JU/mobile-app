import 'package:flutter/material.dart';
import 'dart:math';

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //this is current "mock-data"
    //not sure about the exakt form of the path data we will receive.
    final points1 = [
      Offset(1, 1),
      Offset(100, 75),
      Offset(-100, 250),
      Offset(130, 200),
      Offset(-130, -90),
    ];
    final points2 = [
      Offset(-30, -20),
      Offset(-30, -50),
      Offset(-70, 10),
      Offset(40, 40),
    ];
    final paths = [points1, points2];

    // all paths are looped through one by one
    for (List<Offset> points in paths) {
      // paint is set with a random color to distinguish them from each other
      Paint paint = Paint()
        ..color = Colors.primaries[Random().nextInt(Colors.primaries.length)]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      Path path = Path();
      Offset origin = points[0];

      //a specific path is looped through
      path.moveTo(origin.dx, origin.dy);
      for (Offset o in points) {
        path.lineTo(o.dx, o.dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
