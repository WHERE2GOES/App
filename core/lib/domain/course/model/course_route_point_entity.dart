import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_route_point_entity.freezed.dart';

@freezed
abstract class CourseRoutePointEntity with _$CourseRoutePointEntity {
  const factory CourseRoutePointEntity({
    required double latitude,
    required double longitude,
  }) = _CourseRoutePointEntity;
}
