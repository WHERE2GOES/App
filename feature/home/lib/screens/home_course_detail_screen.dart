import 'dart:math';
import 'dart:typed_data';

import 'package:core/utils/has_final_consonant.dart';
import 'package:design/theme/theme_colors.dart';
import 'package:design/widget/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home/models/course_score.dart';
import 'package:home/models/course_spot.dart';
import 'package:home/widgets/polygon_graph.dart';

class HomeCourseDetailScreen extends StatefulWidget {
  const HomeCourseDetailScreen({
    super.key,
    required this.bannerImage,
    required this.courseName,
    required this.courseDescription,
    required this.courseScore,
    required this.spotCategories,
    required this.onBackButtonClicked,
    required this.onSubmitButtonClicked,
  });

  final Uint8List? bannerImage;
  final String courseName;
  final String? courseDescription;
  final CourseScore? courseScore;
  final List<({RichText title, List<CourseSpot>? spots})> spotCategories;
  final VoidCallback onBackButtonClicked;
  final VoidCallback onSubmitButtonClicked;

  @override
  State<HomeCourseDetailScreen> createState() => _HomeCourseDetailScreenState();
}

class _HomeCourseDetailScreenState extends State<HomeCourseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final bannerImage = widget.bannerImage;
    final spotCategories = widget.spotCategories;

    return Container(
      color: ThemeColors.sparseYellow,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            if (bannerImage != null) Image.memory(bannerImage),
            const SizedBox(height: 33),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildCourseSummary(),
            ),
            const SizedBox(height: 75),
            _buildCourseScoreGraph(),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final spotCategory = spotCategories[index];

                return _buildSpotCategoryList(
                  key: ValueKey(spotCategory.title),
                  title: spotCategory.title,
                  spots: spotCategory.spots,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 37),
              itemCount: spotCategories.length,
            ),
            _buildSubmitButtonBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseSummary() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.1),
        border: Border.all(color: ThemeColors.grey800, width: 0.5),
        color: Colors.white,
      ),
      child: Column(
        spacing: 8,
        children: [
          Row(
            spacing: 14,
            children: [
              Transform.rotate(
                angle: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: SvgPicture.asset(
                    "packages/home/assets/images/txt_start_quote.svg",
                    width: 25,
                  ),
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.courseName,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.grey800,
                        ),
                      ),
                      TextSpan(
                        text:
                            "${hasFinalConsonant(widget.courseName) ? "은" : "는"} 어떤 코스일까요?",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: ThemeColors.grey800.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Transform.rotate(
                angle: pi,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: SvgPicture.asset(
                    "packages/home/assets/images/txt_start_quote.svg",
                    width: 25,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: 6,
            children: [
              Text(
                "Ask",
                style: TextStyle(
                  color: ThemeColors.grey800,
                  fontSize: 12,
                  letterSpacing: -0.2,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                width: 23.31,
                height: 3,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      decoration: BoxDecoration(color: ThemeColors.grey800),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 3,
                        height: 3,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: ThemeColors.grey800,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.courseDescription ?? "",
                style: TextStyle(
                  color: ThemeColors.grey800,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseScoreGraph() {
    final size = MediaQuery.of(context).size.width - 120;

    return CourseScorePolygonGraph(
      size: Size(size, size),
      courseScore:
          widget.courseScore ??
          (weather: 0, festival: 0, difficulty: 0, food: 0, culture: 0),
    );
  }

  Widget _buildSpotCategoryList({
    required Key key,
    required RichText title,
    required List<CourseSpot>? spots,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4.7),
          child: title,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 115,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemBuilder: (BuildContext context, int index) {
                    final spot = spots?[index];
                    final image = spot?.image;

                    return Container(
                      width: 115,
                      height: 115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: ThemeColors.grey800,
                          width: 0.5,
                        ),
                        color: Colors.white,
                      ),
                      child: image != null
                          ? Image.memory(
                              image,
                              width: 115,
                              height: 115,
                              fit: BoxFit.cover,
                            )
                          : null,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(width: 16),
                  itemCount: spots?.length ?? 0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubmitButtonBar() {
    return CustomBottomSheet(
      showDragHandle: false,
      initialHeight: 128 + MediaQuery.of(context).viewPadding.bottom,
      child: Stack(
        children: [
          Positioned(
            left: 10.45,
            top: 17.53,
            child: SvgPicture.asset(
              "packages/home/assets/images/img_dotted_line_deco_1.svg",
              width: 79.72,
            ),
          ),
          Positioned(
            right: -13.43,
            top: 23.03,
            child: SvgPicture.asset(
              "packages/home/assets/images/img_dotted_line_deco_2.svg",
              width: 105.16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              spacing: 21.37,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.courseName,
                        style: TextStyle(
                          color: ThemeColors.pastelGreen,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: " 코스를 진행할까요?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    height: 37.24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ThemeColors.pastelGreen.withValues(alpha: 0.4),
                        width: 0.6,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFF61615C),
                    ),
                    child: Text(
                      "코스 진행하기",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
