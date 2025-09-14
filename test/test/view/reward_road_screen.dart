import 'package:flutter/material.dart';
import 'package:reward/screens/reward_road_screen.dart';

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
      body: RewardRoadScreen(
        certificates: [
          (isCompleted: true, onClicked: () {}),
          (isCompleted: true, onClicked: () {}),
          (isCompleted: true, onClicked: () {}),
          (isCompleted: true, onClicked: () {}),
          (isCompleted: true, onClicked: () {}),
          (isCompleted: true, onClicked: () {}),
          (isCompleted: true, onClicked: () {}),
          (isCompleted: false, onClicked: () {}),
          (isCompleted: false, onClicked: () {}),
          (isCompleted: false, onClicked: () {}),
          (isCompleted: false, onClicked: () {}),
          (isCompleted: false, onClicked: () {}),
          (isCompleted: false, onClicked: () {}),
          (isCompleted: false, onClicked: () {}),
          (isCompleted: false, onClicked: () {}),
        ],
        completeButton: null,
      ),
    );
  }
}
