import 'dart:typed_data';

import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.bannerImage,
    required this.courseInProgressCard,
    required this.recommendedCourses,
    required this.fitCourse,
  });

  final Uint8List? bannerImage;
  final ({VoidCallback onClicked})? courseInProgressCard;
  final List<
    ({
      Uint8List? image,
      String placeName,
      VoidCallback onClicked,
      VoidCallback? onRendered,
    })
  >?
  recommendedCourses;
  final ({Uint8List? image, String typeName, VoidCallback onClicked})?
  fitCourse;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final bannerImage = widget.bannerImage;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ThemeColors.sparseYellow,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          spacing: 38,
          children: [
            if (bannerImage != null)
              Image.memory(bannerImage, width: double.infinity),
            if (widget.courseInProgressCard != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildCurrentCourseWidget(),
              ),
            if (widget.recommendedCourses != null)
              _buildRecommendedCourseList(),
            if (widget.fitCourse != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildFitCourseCard(),
              ),
            SizedBox(height: MediaQuery.of(context).viewPadding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentCourseWidget() {
    final courseInProgressCard = widget.courseInProgressCard;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5.5,
      children: [
        Text(
          "나의 경로 현황",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: ThemeColors.grey800,
          ),
        ),
        GestureDetector(
          onTap: courseInProgressCard?.onClicked,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ThemeColors.pastelYellow,
              border: Border.all(width: 0.6, color: ThemeColors.grey800),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 11,
                right: 11,
                top: 14,
                bottom: 10,
              ),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7.8,
                      vertical: 2.5,
                    ),
                    decoration: BoxDecoration(
                      color: ThemeColors.highlightedRed,
                      borderRadius: BorderRadius.circular(3.56),
                      border: Border.all(
                        width: 0.4,
                        color: ThemeColors.grey800,
                      ),
                    ),
                    child: SvgPicture.asset(
                      "assets/images/ic_human.svg",
                      package: "home",
                      width: 14.8,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "진행중인 경로를 ",
                          style: TextStyle(
                            color: ThemeColors.grey800,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text: "이어서 탐색",
                          style: TextStyle(
                            color: ThemeColors.grey800,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "할까요?",
                          style: TextStyle(
                            color: ThemeColors.grey800,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedCourseList() {
    final recommendedCourses = widget.recommendedCourses;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5.5,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Today AI 경로 추천",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: ThemeColors.grey800,
            ),
          ),
        ),
        SizedBox(
          height: 96.34,
          child: recommendedCourses != null
              ? ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemBuilder: (BuildContext context, int index) {
                    final recommendedCourse = recommendedCourses[index];
                    final image = recommendedCourse.image;

                    recommendedCourse.onRendered?.call();

                    return GestureDetector(
                      onTap: recommendedCourse.onClicked,
                      child: Container(
                        width: 125.17,
                        height: double.infinity,
                        clipBehavior: Clip.antiAlias,
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
                                width: 96.34,
                                height: 96.34,
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(width: 10.6),
                  itemCount: recommendedCourses.length,
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildFitCourseCard() {
    final fitCourse = widget.fitCourse;
    final image = fitCourse?.image;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5.5,
      children: [
        Text(
          "맞춤형 추천 코스",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: ThemeColors.grey800,
          ),
        ),
        GestureDetector(
          onTap: fitCourse?.onClicked,
          child: Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(width: 0.6, color: ThemeColors.grey800),
              borderRadius: BorderRadius.circular(5),
            ),
            child: image != null
                ? Image.memory(image, width: double.infinity)
                : null,
          ),
        ),
      ],
    );
  }
}
