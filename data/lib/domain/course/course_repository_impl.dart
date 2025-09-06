import 'package:core/common/result.dart';
import 'package:core/domain/course/course_repository.dart';
import 'package:core/domain/course/model/course_info_entity.dart';
import 'package:core/domain/course/model/course_property_entity.dart';
import 'package:core/domain/course/model/course_property_type.dart';
import 'package:core/domain/course/model/current_course_entity.dart';
import 'package:core/domain/course/model/fitted_course_entity.dart';
import 'package:core/domain/course/model/recommended_course_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CourseRepository)
class CourseRepositoryImpl implements CourseRepository {
  @override
  Future<Result<void>> endCourse() {
    // TODO: implement endCourse
    throw UnimplementedError();
  }

  @override
  Future<Result<CourseInfoEntity>> getCourseInfo({required int courseId}) {
    // TODO: implement getCourseInfo
    throw UnimplementedError();
  }

  @override
  Future<Result<List<CoursePropertyEntity>>> getCourseProperties({required int courseId, required CoursePropertyType type, required int page, required int size}) {
    // TODO: implement getCourseProperties
    throw UnimplementedError();
  }

  @override
  Future<Result<CurrentCourseEntity?>> getCurrentCourse() {
    // TODO: implement getCurrentCourse
    throw UnimplementedError();
  }

  @override
  Future<Result<FittedCourseEntity>> getFittedCourses() {
    // TODO: implement getFittedCourses
    throw UnimplementedError();
  }

  @override
  Future<Result<List<RecommendedCourseEntity>>> getRecommendedCourses({required page, required size}) {
    // TODO: implement getRecommendedCourses
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> startCourse({required int courseId}) {
    // TODO: implement startCourse
    throw UnimplementedError();
  }
}