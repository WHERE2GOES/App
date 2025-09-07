import 'dart:typed_data';

import 'package:core/common/result.dart';
import 'package:core/domain/course/course_repository.dart';
import 'package:core/domain/course/model/course_info_entity.dart';
import 'package:core/domain/course/model/course_property_entity.dart';
import 'package:core/domain/course/model/course_property_type.dart';
import 'package:core/domain/course/model/fitted_course_entity.dart';
import 'package:core/domain/course/model/recommended_course_entity.dart';
import 'package:core/domain/onboarding/onboarding_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeViewModel extends ChangeNotifier {
  final CourseRepository courseRepository;
  final OnboardingRepository onboardingRepository;

  HomeViewModel({
    required this.courseRepository,
    required this.onboardingRepository,
  });

  Future<Uint8List?>? bannerImage;
  List<RecommendedCourseEntity>? recommendedCourses;
  FittedCourseEntity? fittedCourse;
  int? _selectedCourseId;
  CourseInfoEntity? courseInfo;
  List<CoursePropertyEntity>? foodSpots;
  List<CoursePropertyEntity>? photoSpotSpots;
  List<CoursePropertyEntity>? activitySpots;

  Future<void> loadBannerImage() async {
    bannerImage = Future.sync(() async {
      final result = await onboardingRepository.getBannerImage();
      final success = result as Success<Uint8List>;
      return success.data;
    });

    notifyListeners();
  }

  Future<void> loadRecommendedCourses() async {
    recommendedCourses = null;
    notifyListeners();

    final result = await courseRepository.getRecommendedCourses(
      page: 0,
      size: 10,
    );

    if (result is Success<List<RecommendedCourseEntity>>) {
      recommendedCourses = result.data;
      notifyListeners();
    }
  }

  Future<void> loadFittedCourse() async {
    fittedCourse = null;
    notifyListeners();

    final result = await courseRepository.getFittedCourses();

    if (result is Success<FittedCourseEntity>) {
      fittedCourse = result.data;
      notifyListeners();
    }
  }

  Future<void> loadAll() async {
    await Future.wait([
      loadBannerImage(),
      loadRecommendedCourses(),
      loadFittedCourse(),
    ]);
  }

  Future<void> selectCourse({required int courseId}) async {
    _selectedCourseId = courseId;
    courseInfo = null;
    notifyListeners();

    loadCourseInfo();
  }

  Future<void> unselectCourse() async {
    _selectedCourseId = null;
    courseInfo = null;
    foodSpots = null;
    photoSpotSpots = null;
    activitySpots = null;
    notifyListeners();
  }

  Future<void> loadCourseInfo() async {
    courseInfo = null;
    notifyListeners();

    final courseId = _selectedCourseId;
    if (courseId == null) return;
    final result = await courseRepository.getCourseInfo(courseId: courseId);

    if (result is Success<CourseInfoEntity>) {
      courseInfo = result.data;
      notifyListeners();
    }
  }

  Future<void> loadCourseProperties({
    required int page,
    required int size,
    required CoursePropertyType type,
  }) async {
    final courseId = _selectedCourseId;
    if (courseId == null) return;

    switch (type) {
      case CoursePropertyType.food:
        foodSpots = null;
        break;
      case CoursePropertyType.photoSpot:
        photoSpotSpots = null;
        break;
      case CoursePropertyType.activity:
        activitySpots = null;
        break;
    }

    notifyListeners();

    final result = await courseRepository.getCourseProperties(
      courseId: courseId,
      type: type,
      page: page,
      size: size,
    );

    if (result is Success<List<CoursePropertyEntity>>) {
      final spots = result.data;

      switch (type) {
        case CoursePropertyType.food:
          foodSpots = spots;
          break;
        case CoursePropertyType.photoSpot:
          photoSpotSpots = spots;
          break;
        case CoursePropertyType.activity:
          activitySpots = spots;
          break;
      }

      notifyListeners();
    }
  }
}
