import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_course_entity.freezed.dart';

@freezed
abstract class CurrentCourseEntity with _$CurrentCourseEntity {
  const factory CurrentCourseEntity({
    required int id,
    required String name,
  }) = _CurrentCourseEntity;
}