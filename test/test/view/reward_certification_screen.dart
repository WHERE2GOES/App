import 'package:flutter/material.dart';
import 'package:reward/screens/reward_certification_screen.dart';

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
      body: RewardCertificationScreen(
        certificateOrder: 6,
        onBackButtonClicked: () {},
        onCameraButtonClicked: () {},
      ),
    );
  }
}
