import 'dart:typed_data';

import 'package:core/domain/course/model/course_property_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_property_entity.freezed.dart';

@freezed
abstract class CoursePropertyEntity with _$CoursePropertyEntity {
  const factory CoursePropertyEntity({
    required Future<Uint8List?> image,
    required String name,
    required CoursePropertyType type,
  }) = _CoursePropertyEntity;
}
