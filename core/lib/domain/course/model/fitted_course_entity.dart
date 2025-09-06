import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'fitted_course_entity.freezed.dart';

@freezed
abstract class FittedCourseEntity with _$FittedCourseEntity {
  const factory FittedCourseEntity({
    required int id,
    required String name,
    required Future<Uint8List?> image,
  }) = _FittedCourseEntity;
}