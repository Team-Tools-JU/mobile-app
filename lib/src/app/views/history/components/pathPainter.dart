import 'package:flutter/material.dart';
import 'dart:math';

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
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

    for (List<Offset> points in paths) {
      Paint paint = Paint()
        ..color = Colors.primaries[Random().nextInt(Colors.primaries.length)]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      //canvas.drawPoints(pointMode, points, paint);
      Path path = Path();
      Offset origin = points[0];
      path.moveTo(origin.dx, origin.dy);
      for (Offset o in points) {
        path.lineTo(o.dx, o.dy);
        //såhär går det lösas med
      }

      //operations here
      //path.moveTo(size.width / 2, size.height / 2);
      //path.lineTo(size.width, size.height);

      //path.addPolygon(points, close);
      //path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
