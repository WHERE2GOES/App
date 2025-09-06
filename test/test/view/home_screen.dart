import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home/screens/home_screen.dart';
import 'package:logger/web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final logger = Logger()..init;
  final bannerImage = await rootBundle.load(
    "assets/images/test_banner_home.png",
  );
  final fitCourseImage = await rootBundle.load(
    "assets/images/test_fit_course.png",
  );

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: "Pretendard"),
      home: _TestApp(
        bannerImage: bannerImage.buffer.asUint8List(),
        fitCourseImage: fitCourseImage.buffer.asUint8List(),
        logger: logger,
      ),
    ),
  );
}

class _TestApp extends StatelessWidget {
  final Uint8List bannerImage;
  final Uint8List fitCourseImage;
  final Logger logger;

  const _TestApp({
    required this.bannerImage,
    required this.fitCourseImage,
    required this.logger,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(
        bannerImage: Future.value(bannerImage),
        courseInProgressCard: (onClicked: () {}),
        recommendedCourses: List.generate(
          30,
          (index) => (
            image: Future.value(null),
            placeName: "용산",
            onClicked: () {},
            onRendered: () => logger.d("Rendered! index: $index"),
          ),
        ),
        fitCourse: (
          image: Future.value(fitCourseImage),
          typeName: "용산",
          onClicked: () {},
        ),
      ),
    );
  }
}
