import 'package:flutter/material.dart';
import 'package:login/screens/login_course_preference_start_screen.dart';

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
      body: LoginCoursePreferencesStartScreen(onStartButtonClicked: () {}),
    );
  }
}
