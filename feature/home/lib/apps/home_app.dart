import 'package:collection/collection.dart';
import 'package:core/domain/course/model/course_property_type.dart';
import 'package:design/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:home/models/course_spot.dart';
import 'package:home/screens/home_course_detail_screen.dart';
import 'package:home/screens/home_screen.dart';
import 'package:home/vms/home_view_model.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({
    super.key,
    required this.vm,
    required this.onCurrentCourseCardClicked,
    required this.onCourseStarted,
  });

  final HomeViewModel vm;
  final VoidCallback onCurrentCourseCardClicked;
  final VoidCallback onCourseStarted;

  @override
  State<StatefulWidget> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    widget.vm.loadAll();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return BackButtonListener(
              onBackButtonPressed: () async {
                _back();
                return true;
              },
              child: ListenableBuilder(
                listenable: widget.vm,
                builder: (context, child) {
                  return switch (settings.name) {
                    '/' => _buildHomeScreen(),
                    '/course' => _buildHomeCourseDetailScreen(),
                    _ => throw Exception("Invalid route"),
                  };
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHomeScreen() {
    final recommendedCourses = widget.vm.recommendedCourses;
    final fittedCourse = widget.vm.fittedCourse;

    return HomeScreen(
      bannerImage: widget.vm.bannerImage,
      courseInProgressCard: null, // TODO: 진행중인 코스 기능 추가
      recommendedCourses: recommendedCourses
          ?.map(
            (e) => (
              image: e.image,
              placeName: e.name,
              onClicked: () => _onCourseClicked(courseId: e.id),
              onRendered: null,
            ),
          )
          .toList(),
      fitCourse: fittedCourse != null
          ? (
              image: fittedCourse.image,
              typeName: "솔솔산책", // FIXME: 코스의 추천 타입 이름으로 변경 팔요
              onClicked: () =>
                  _onCourseClicked(courseId: widget.vm.fittedCourse!.id),
            )
          : null,
    );
  }

  Widget _buildHomeCourseDetailScreen() {
    final scores = widget.vm.courseInfo?.scores;
    final foodSpots = widget.vm.foodSpots;
    final photoSpotSpots = widget.vm.photoSpotSpots;
    final activitySpots = widget.vm.activitySpots;

    return HomeCourseDetailScreen(
      bannerImage: widget.vm.courseInfo?.bannerImage,
      courseName: widget.vm.courseInfo?.courseName ?? '',
      courseDescription: widget.vm.courseInfo?.description ?? '',
      courseScore: scores != null
          ? (
              culture:
                  scores.firstWhereOrNull((e) => e.name == 'activity')?.score ??
                  0.0,
              difficulty:
                  scores
                      .firstWhereOrNull((e) => e.name == 'difficulty')
                      ?.score ??
                  0.0,
              festival:
                  scores.firstWhereOrNull((e) => e.name == 'festival')?.score ??
                  0.0,
              food:
                  scores.firstWhereOrNull((e) => e.name == 'food')?.score ??
                  0.0,
              weather:
                  scores.firstWhereOrNull((e) => e.name == 'weather')?.score ??
                  0.0,
            )
          : null,
      spotCategories:
          [
                if (foodSpots != null) foodSpots,
                if (photoSpotSpots != null) photoSpotSpots,
                if (activitySpots != null) activitySpots,
              ]
              .map(
                (e) => (
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "${widget.vm.courseInfo?.courseName ?? ''}의 ${switch (e.first.type) {
                                CoursePropertyType.food => "맛있는",
                                CoursePropertyType.photoSpot => "멋있는",
                                CoursePropertyType.activity => "재밌는",
                              }} ",
                          style: TextStyle(color: ThemeColors.grey800),
                        ),
                        TextSpan(
                          text:
                              "${widget.vm.courseInfo?.courseName ?? ''}의 ${switch (e.first.type) {
                                CoursePropertyType.food => "먹거리",
                                CoursePropertyType.photoSpot => "사진스팟",
                                CoursePropertyType.activity => "놀거리",
                              }}",
                          style: TextStyle(
                            color: ThemeColors.grey800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: switch (e.first.type) {
                            CoursePropertyType.food => "는?",
                            CoursePropertyType.photoSpot => "은?",
                            CoursePropertyType.activity => "는?",
                          },
                          style: TextStyle(color: ThemeColors.grey800),
                        ),
                      ],
                    ),
                  ),
                  spots: e
                      .map(
                        (spot) =>
                            CourseSpot(name: spot.name, image: spot.image),
                      )
                      .toList(),
                ),
              )
              .toList(),
      onBackButtonClicked: _back,
      onSubmitButtonClicked: _onCourseSubmitted,
    );
  }

  void _back() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      _navigatorKey.currentState?.pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _onCourseClicked({required dynamic courseId}) {
    widget.vm.selectCourse(courseId: courseId);
    _navigatorKey.currentState
        ?.pushNamed('/course')
        .then((value) => widget.vm.unselectCourse());
  }

  void _onCourseSubmitted() {
    widget.vm.startCourse().then((isSucceed) {
      if (isSucceed) widget.onCourseStarted();
    });
  }
}
