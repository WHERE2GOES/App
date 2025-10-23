import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home/models/course_spot.dart';
import 'package:home/screens/home_course_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bannerImage = await rootBundle.load("assets/images/test_banner.png");

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: "Pretendard"),
      home: _TestApp(bannerImage: bannerImage.buffer.asUint8List()),
    ),
  );
}

class _TestApp extends StatelessWidget {
  final Uint8List bannerImage;

  const _TestApp({required this.bannerImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeCourseDetailScreen(
        bannerImage: Future.value(bannerImage),
        courseName: '용산',
        courseDescription: "용산은 남산타워가 보이고 맛집이 많은 곳!",
        courseScore: (
          weather: 1.0,
          festival: 0.5,
          difficulty: 0.3,
          food: 0.9,
          culture: 0.7,
        ),
        isSubmitButtonEnabled: true,
        spotCategories: [
          (
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "용산의 맛있는 먹거리는?",
                    style: TextStyle(color: ThemeColors.grey800),
                  ),
                ],
              ),
            ),
            spots: [
              CourseSpot(name: "", image: Future.value(null)),
              CourseSpot(name: "", image: Future.value(null)),
              CourseSpot(name: "", image: Future.value(null)),
            ],
          ),
          (
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "용산의 맛있는 먹거리는?",
                    style: TextStyle(color: ThemeColors.grey800),
                  ),
                ],
              ),
            ),
            spots: [
              CourseSpot(name: "", image: Future.value(null)),
              CourseSpot(name: "", image: Future.value(null)),
              CourseSpot(name: "", image: Future.value(null)),
            ],
          ),
          (
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "용산의 맛있는 먹거리는?",
                    style: TextStyle(color: ThemeColors.grey800),
                  ),
                ],
              ),
            ),
            spots: [
              CourseSpot(name: "", image: Future.value(null)),
              CourseSpot(name: "", image: Future.value(null)),
              CourseSpot(name: "", image: Future.value(null)),
            ],
          ),
        ],
        onBackButtonClicked: () {},
        onSubmitButtonClicked: () {},
      ),
    );
  }
}
