import 'dart:typed_data';

import 'package:core/domain/course/model/course_score_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_info_entity.freezed.dart';

@freezed
abstract class CourseInfoEntity with _$CourseInfoEntity {
  const factory CourseInfoEntity({
    required int id,
    required String courseName,
    required String regionName,
    required String description,
    required Future<Uint8List?> bannerImage,
    required Iterable<CourseScoreEntity> scores,
  }) = _CourseInfoEntity;
}