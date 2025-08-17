import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_score_entity.freezed.dart';

@freezed
abstract class CourseScoreEntity with _$CourseScoreEntity {
  const factory CourseScoreEntity({required String name, required int score}) =
      _CourseScoreEntity;
}
