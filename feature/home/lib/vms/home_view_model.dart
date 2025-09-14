import 'dart:typed_data';

import 'package:core/common/result.dart';
import 'package:core/domain/course/course_repository.dart';
import 'package:core/domain/course/model/course_info_entity.dart';
import 'package:core/domain/course/model/course_property_entity.dart';
import 'package:core/domain/course/model/course_property_type.dart';
import 'package:core/domain/course/model/current_course_entity.dart';
import 'package:core/domain/course/model/fitted_course_entity.dart';
import 'package:core/domain/course/model/recommended_course_entity.dart';
import 'package:core/domain/onboarding/onboarding_repository.dart';
import 'package:core/domain/user/model/course_preference_type.dart';
import 'package:core/domain/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeViewModel extends ChangeNotifier {
  final CourseRepository courseRepository;
  final OnboardingRepository onboardingRepository;
  final UserRepository userRepository;

  HomeViewModel({
    required this.courseRepository,
    required this.onboardingRepository,
    required this.userRepository,
  });

  Future<Uint8List?>? bannerImage;
  List<RecommendedCourseEntity>? recommendedCourses;
  List<FittedCourseEntity>? fitCourses;
  CurrentCourseEntity? currentCourse;
  CoursePreferenceType? coursePreferenceType;
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

  Future<void> loadCoursePreferenceType() async {
    coursePreferenceType = null;
    notifyListeners();

    final result = await userRepository.getCoursePreferenceType();

    if (result is Success<CoursePreferenceType>) {
      coursePreferenceType = result.data;
      notifyListeners();
    }
  }

  Future<void> loadCurrentCourse() async {
    currentCourse = null;
    notifyListeners();

    final result = await courseRepository.getCurrentCourse();

    if (result is Success<CurrentCourseEntity?>) {
      currentCourse = result.data;
      notifyListeners();
    }
  }

  Future<void> loadAll() async {
    await Future.wait([
      loadBannerImage(),
      loadCurrentCourse(),
      loadRecommendedCourses(),
      loadCoursePreferenceType(),
    ], eagerError: false);
  }

  Future<void> loadFitCourses() async {
    fitCourses = null;
    notifyListeners();

    final result = await courseRepository.getFittedCourses();

    if (result is Success<List<FittedCourseEntity>>) {
      fitCourses = result.data;
      notifyListeners();
    }
  }

  Future<void> selectCourse({required int courseId}) async {
    _selectedCourseId = courseId;
    courseInfo = null;
    notifyListeners();

    loadCourseInfo();
    loadCourseProperties(page: 0, size: 5, type: CoursePropertyType.food);
    loadCourseProperties(page: 0, size: 5, type: CoursePropertyType.photoSpot);
    loadCourseProperties(page: 0, size: 5, type: CoursePropertyType.activity);
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

  Future<bool> startCourse() async {
    final courseId = _selectedCourseId;
    if (courseId == null) return false;
    final result = await courseRepository.startCourse(courseId: courseId);
    return result is Success<void>;
  }
}
