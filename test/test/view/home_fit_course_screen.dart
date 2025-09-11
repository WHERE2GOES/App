import 'package:flutter/material.dart';
import 'package:home/screens/home_fit_course_screen.dart';
import 'package:core/domain/user/model/course_preference_type.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: "Pretendard"),
      home: _TestApp(),
    ),
  );
}

class _TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeFitCourseScreen(
        type: CoursePreferenceType.c,
        courses: [
          (title: "title", onClicked: () {}),
          (title: "title", onClicked: () {}),
          (title: "title", onClicked: () {}),
        ],
      ),
    );
  }
}
