import 'dart:math';

import 'package:collection/collection.dart';
import 'package:dashed_path/dashed_path.dart';
import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home/models/course_score.dart';

final List<({String asset, double width})> _images = [
  (asset: "packages/home/assets/images/txt_weather.svg", width: 40.25),
  (asset: "packages/home/assets/images/txt_festival.svg", width: 43.08),
  (asset: "packages/home/assets/images/txt_culture.svg", width: 49),
  (asset: "packages/home/assets/images/txt_food.svg", width: 38.25),
  (asset: "packages/home/assets/images/txt_difficulty.svg", width: 48),
];

class CourseScorePolygonGraph extends StatefulWidget {
  const CourseScorePolygonGraph({
    super.key,
    required this.courseScore,
    required this.size,
  });

  final CourseScore courseScore;
  final Size size;

  @override
  State<CourseScorePolygonGraph> createState() =>
      _CourseScorePolygonGraphState();
}

class _CourseScorePolygonGraphState extends State<CourseScorePolygonGraph> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          size: widget.size,
          painter: _PolygonGraphPainter(courseScore: widget.courseScore),
        ),
        ...[
          _getPoints(widget.size, [1, 1, 1, 1, 1]),
          _getPoints(widget.size, _getScore(widget.courseScore)),
        ].mapIndexed(
          (i, points) => CustomPaint(
            size: widget.size,
            painter: DashedPathPainter(
              originalPath: _getPath(points),
              pathColor: ThemeColors.pastelOrange,
              strokeWidth: i + 0.5,
              dashGapLength: 3 * i + 0.1,
              dashLength: 3,
            ),
          ),
        ),
        ..._getPoints(widget.size, [1, 1, 1, 1, 1]).mapIndexed(
          (i, point) => Positioned(
            left: point.x - 33,
            top: point.y - 33,
            child: Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: ThemeColors.grey800),
                borderRadius: BorderRadius.circular(999),
                color: ThemeColors.pastelYellow,
              ),
              child: Center(
                child: SvgPicture.asset(
                  _images[i].asset,
                  width: _images[i].width,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PolygonGraphPainter extends CustomPainter {
  const _PolygonGraphPainter({required this.courseScore});

  final CourseScore courseScore;

  @override
  void paint(Canvas canvas, Size size) {
    final List<Paint> paints = [
      Paint()
        ..color = ThemeColors.sparseOrange
        ..style = PaintingStyle.fill,
      Paint()
        ..color = ThemeColors.pastelGreen
        ..style = PaintingStyle.fill,
    ];

    final List<List<double>> scores = [
      [1, 1, 1, 1, 1],
      _getScore(courseScore),
    ];

    for (final i in [0, 1]) {
      final score = scores[i];
      final paint = paints[i];
      final path = _getPath(_getPoints(size, score));
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! _PolygonGraphPainter ||
        oldDelegate.courseScore != courseScore;
  }
}

Path _getPath(List<({double x, double y})> points) {
  final path = Path();

  points.forEachIndexed((i, point) {
    if (i == 0) {
      path.moveTo(point.x, point.y);
    } else {
      path.lineTo(point.x, point.y);
    }
  });

  path.close();
  return path;
}

List<({double x, double y})> _getPoints(Size size, List<double> scores) {
  final int n = scores.length;
  final double centerX = size.width / 2;
  final double centerY = size.height / 2;
  final double fullRadius = size.width / 2;
  final double angle = 2 * pi / n;

  return scores.mapIndexed((i, radius) {
    final double scoreRadius = fullRadius * radius;
    final double x = centerX + scoreRadius * cos(i * angle - pi / 2);
    final double y = centerY + scoreRadius * sin(i * angle - pi / 2);

    return (x: x, y: y);
  }).toList();
}

List<double> _getScore(CourseScore courseScore) {
  return [
    courseScore.weather,
    courseScore.festival,
    courseScore.culture,
    courseScore.food,
    courseScore.difficulty,
  ];
}
