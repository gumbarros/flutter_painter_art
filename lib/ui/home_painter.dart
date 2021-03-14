import 'dart:ui';

import 'package:flutter_painter_art/models/drawing_area.dart';
import 'package:flutter/material.dart';

class HomePainter extends CustomPainter {
  final List<DrawingArea> points;
  final Color color;
  final double strokeWidth;
  List<DrawingArea> drawings = [];

  HomePainter({@required this.points, @required this.color, @required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint background = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i].point, points[i + 1].point, points[i].areaPaint);
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(PointMode.points, [points[i].point], points[i].areaPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}