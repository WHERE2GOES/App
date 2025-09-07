import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommended_course_entity.freezed.dart';

@freezed
abstract class RecommendedCourseEntity with _$RecommendedCourseEntity {
  const factory RecommendedCourseEntity({
    required int id,
    required String name,
    required Future<Uint8List?> image,
  }) = _RecommendedCourseEntity;
}
