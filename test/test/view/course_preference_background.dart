import 'package:flutter/material.dart';
import 'package:design/models/course_preference_background_type.dart';
import 'package:design/widget/course_preference_background.dart';

void main() {
  runApp(
    const MaterialApp(
      home: CoursePreferenceBackground(type: CoursePreferenceBackgroundType.h),
    ),
  );
}
