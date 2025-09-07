import 'package:core/common/result.dart';
import 'package:core/domain/course/model/course_info_entity.dart';
import 'package:core/domain/course/model/course_property_entity.dart';
import 'package:core/domain/course/model/course_property_type.dart';
import 'package:core/domain/course/model/current_course_entity.dart';
import 'package:core/domain/course/model/fitted_course_entity.dart';
import 'package:core/domain/course/model/recommended_course_entity.dart';

abstract interface class CourseRepository {
  /// 현재 진행 중인 코스
  Future<Result<CurrentCourseEntity?>> getCurrentCourse();

  /// 추천 코스 목록
  Future<Result<List<RecommendedCourseEntity>>> getRecommendedCourses({
    required page,
    required size,
  });

  /// 추천 코스 목록 (개인 맞춤형)
  Future<Result<FittedCourseEntity>> getFittedCourses();

  /// 특정 코스의 정보
  Future<Result<CourseInfoEntity>> getCourseInfo({required dynamic courseId});

  /// 특정 코스의 특성 정보
  Future<Result<List<CoursePropertyEntity>>> getCourseProperties({
    required dynamic courseId,
    required CoursePropertyType type,
    required int page,
    required int size,
  });

  /// 코스 시작
  Future<Result<void>> startCourse({required dynamic courseId});

  /// 코스 종료
  Future<Result<void>> endCourse();
}
