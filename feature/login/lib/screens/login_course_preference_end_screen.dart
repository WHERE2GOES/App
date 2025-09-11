import 'package:core/domain/user/model/course_preference_type.dart';
import 'package:design/models/course_preference_background_type.dart';
import 'package:design/theme/theme_colors.dart';
import 'package:design/widget/course_preference_background.dart';
import 'package:flutter/material.dart';

class LoginCoursePreferenceEndScreen extends StatefulWidget {
  const LoginCoursePreferenceEndScreen({
    super.key,
    required this.backgroundType,
    required this.onGoToNextScreen,
  });

  final CoursePreferenceType? backgroundType;
  final VoidCallback onGoToNextScreen;

  @override
  State<LoginCoursePreferenceEndScreen> createState() =>
      _LoginCoursePreferenceEndScreenState();
}

class _LoginCoursePreferenceEndScreenState
    extends State<LoginCoursePreferenceEndScreen> {
  bool _showType = false;
  bool _canGoToNextScreen = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _showType = true);
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _canGoToNextScreen = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundType = widget.backgroundType;

    return Container(
      color: ThemeColors.highlightedRed,
      child: GestureDetector(
        onTap: _canGoToNextScreen ? widget.onGoToNextScreen : null,
        child: Stack(
          children: [
            const SizedBox.expand(
              child: Center(
                child: Text(
                  "당신의 국토대장정 취향은..",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _showType ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: backgroundType != null
                  ? CoursePreferenceBackground(
                      type: switch (backgroundType) {
                        CoursePreferenceType.a =>
                          CoursePreferenceBackgroundType.a,
                        CoursePreferenceType.b =>
                          CoursePreferenceBackgroundType.b,
                        CoursePreferenceType.c =>
                          CoursePreferenceBackgroundType.c,
                        CoursePreferenceType.d =>
                          CoursePreferenceBackgroundType.d,
                        CoursePreferenceType.e =>
                          CoursePreferenceBackgroundType.e,
                        CoursePreferenceType.f =>
                          CoursePreferenceBackgroundType.f,
                        CoursePreferenceType.g =>
                          CoursePreferenceBackgroundType.g,
                        CoursePreferenceType.h =>
                          CoursePreferenceBackgroundType.h,
                      },
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
