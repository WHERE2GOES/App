import 'package:core/common/result.dart';
import 'package:core/domain/course/model/current_cource_entity.dart';
import 'package:core/domain/course/model/recommended_course_entity.dart';

abstract interface class CourseRepository {
  /// 현재 코스 진행 여부
  Future<Result<bool>> get isCourseInProgress;

  /// 현재 진행 중인 코스
  Future<Result<CurrentCourceEntity>> get currentCourse;

  /// 추천 코스 목록
  Future<Result<List<RecommendedCourseEntity>>> get recommendedCourses;

  /// 코스 시작
  /// 
  /// 성공 여부를 반환한다.
  Future<Result<bool>> startCourse({required int courseId});

  /// 코스 종료
  /// 
  /// 성공 여부를 반환한다.
  Future<Result<bool>> endCourse();
}