import 'package:flutter/material.dart';
import 'package:navigation/apps/navigation_app.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: "Pretendard"),
      home: Scaffold(body: NavigationApp()),
    ),
  );
}
