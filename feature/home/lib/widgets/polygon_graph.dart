import 'dart:math';

import 'package:flutter/material.dart';
import 'package:home/models/course_score.dart';

class CourseScorePolygonGraph extends StatelessWidget {
  const CourseScorePolygonGraph({
    super.key,
    required this.courseScore,
  });

  final CourseScore courseScore;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(150, 150),
      painter: _PolygonGraphPainter(courseScore: courseScore),
    );
  }
}

class _PolygonGraphPainter extends CustomPainter {
  _PolygonGraphPainter({
    required this.courseScore,
  });

  final CourseScore courseScore;

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width / 2;

    final Paint linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint fillPaint = Paint()
      ..color = Colors.blue.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    final Path path = Path();

    final double angle = 2 * pi / 5;

    // Draw the polygon
    for (int i = 0; i < 5; i++) {
      final double x = centerX + radius * cos(i * angle - pi / 2);
      final double y = centerY + radius * sin(i * angle - pi / 2);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, linePaint);

    // Draw the data polygon
    final Path dataPath = Path();
    final List<double> scores = [
      courseScore.weather,
      courseScore.festival,
      courseScore.culture,
      courseScore.food,
      courseScore.difficulty,
    ];

    for (int i = 0; i < 5; i++) {
      final double scoreRadius = radius * scores[i];
      final double x = centerX + scoreRadius * cos(i * angle - pi / 2);
      final double y = centerY + scoreRadius * sin(i * angle - pi / 2);
      if (i == 0) {
        dataPath.moveTo(x, y);
      } else {
        dataPath.lineTo(x, y);
      }
    }
    dataPath.close();
    canvas.drawPath(dataPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}