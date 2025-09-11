import 'dart:math';

import 'package:core/domain/user/model/course_preference_type.dart';
import 'package:design/models/course_preference_background_type.dart';
import 'package:design/theme/theme_colors.dart';
import 'package:design/widget/course_preference_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeFitCourseScreen extends StatefulWidget {
  const HomeFitCourseScreen({
    super.key,
    required this.type,
    required this.courses,
  });

  final CoursePreferenceType type;
  final List<({String title, VoidCallback onClicked})>? courses;

  @override
  State<HomeFitCourseScreen> createState() => _HomeFitCourseScreenState();
}

class _HomeFitCourseScreenState extends State<HomeFitCourseScreen> {
  @override
  Widget build(BuildContext context) {
    final courses = widget.courses;

    final textColor = switch (widget.type) {
      CoursePreferenceType.b => Color(0xFF868686),
      CoursePreferenceType.e => Color(0xFF868686),
      CoursePreferenceType.h => Color(0xFF868686),
      _ => Colors.white,
    };

    final textPointColor = switch (widget.type) {
      CoursePreferenceType.a => Color(0xFFD6FDC3),
      CoursePreferenceType.b => Color(0xFF2492D7),
      CoursePreferenceType.c => Color(0xFFD6FDC3),
      CoursePreferenceType.d => Color(0xFFFFD3D3),
      CoursePreferenceType.e => Color(0xFF00A61F),
      CoursePreferenceType.f => Color(0xFFD6FDC3),
      CoursePreferenceType.g => Color(0xFFFF8761),
      CoursePreferenceType.h => Color(0xFFFF8761),
    };

    final badgeColor = switch (widget.type) {
      CoursePreferenceType.a => Color(0xFFFF6A6A),
      CoursePreferenceType.b => Color(0xFF2EECF6),
      CoursePreferenceType.c => Color(0xFFFF8761),
      CoursePreferenceType.d => Color(0xFFD969E3),
      CoursePreferenceType.e => Color(0xFF69E665),
      CoursePreferenceType.f => Color(0xFF6A80FF),
      CoursePreferenceType.g => Color(0xFFFF8761),
      CoursePreferenceType.h => Color(0xFFFF8761),
    };

    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CoursePreferenceBackground(
            isDecorationVisible: false,
            type: switch (widget.type) {
              CoursePreferenceType.a => CoursePreferenceBackgroundType.a,
              CoursePreferenceType.b => CoursePreferenceBackgroundType.b,
              CoursePreferenceType.c => CoursePreferenceBackgroundType.c,
              CoursePreferenceType.d => CoursePreferenceBackgroundType.d,
              CoursePreferenceType.e => CoursePreferenceBackgroundType.e,
              CoursePreferenceType.f => CoursePreferenceBackgroundType.f,
              CoursePreferenceType.g => CoursePreferenceBackgroundType.g,
              CoursePreferenceType.h => CoursePreferenceBackgroundType.h,
            },
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 80,
            children: [
              Row(
                spacing: 14,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Transform.rotate(
                      angle: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SvgPicture.asset(
                          "assets/images/txt_start_quote_white.svg",
                          width: 25,
                          package: "home",
                        ),
                      ),
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: switch (widget.type) {
                            CoursePreferenceType.a => "열정적인 여행을 즐기는 당신",
                            CoursePreferenceType.b => "시원한 걸음거리의 당신",
                            CoursePreferenceType.c => "자유로운 여행을 즐기는 당신",
                            CoursePreferenceType.d => "쌩쌩 달리고 싶은 당신",
                            CoursePreferenceType.e => "널널한 산책을 즐기는 당신",
                            CoursePreferenceType.f => "여유로움을 즐기는 당신",
                            CoursePreferenceType.g => "널널한 산책을 즐기는 당신",
                            CoursePreferenceType.h => "조용한 곳을 좋아하는 당신",
                          },
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: textColor,
                          ),
                        ),
                        TextSpan(text: "\n"),
                        TextSpan(
                          text: widget.type.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: textPointColor,
                          ),
                        ),
                        TextSpan(
                          text: " 코스를 추천합니다",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Transform.rotate(
                      angle: pi,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SvgPicture.asset(
                          "assets/images/txt_start_quote_white.svg",
                          width: 25,
                          package: "home",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (courses != null)
                ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemBuilder: (context, index) {
                    final course = courses[index];
      
                    return Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: ThemeColors.grey800,
                          width: 0.5,
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        spacing: 9,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: badgeColor,
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(
                                color: ThemeColors.grey800,
                                width: 0.35,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 3,
                            ),
                            child: Text(
                              "${index + 1}코스",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            course.title,
                            style: TextStyle(
                              color: ThemeColors.grey800,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            spacing: 5,
                            children: [
                              SvgPicture.asset(
                                "assets/images/ic_human_circle.svg",
                                package: "home",
                                width: 28.45,
                              ),
                              Text(
                                "자세히 보기",
                                style: TextStyle(
                                  color: ThemeColors.grey800.withValues(
                                    alpha: 0.6,
                                  ),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemCount: courses.length,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
