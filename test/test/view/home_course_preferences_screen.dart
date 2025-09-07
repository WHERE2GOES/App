import 'package:flutter/material.dart';
import 'package:login/screens/login_course_preferences_screen.dart';

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
      body: LoginCoursePreferencesScreen(
        totalSteps: 3,
        step: 1,
        question: "어떤 유형의 여행을 선호하시나요?",
        options: [
          (option: "도시 탐방", onClicked: () {}),
          (option: "자연 경관", onClicked: () {}),
        ],
        onBackButtonClicked: () {},
        onNextButtonClicked: () {},
      ),
    );
  }
}
