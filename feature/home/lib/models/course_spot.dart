import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_spot.freezed.dart';

@freezed
abstract class CourseSpot with _$CourseSpot {
  const factory CourseSpot({
    required String name,
    required Future<Uint8List?> image,
  }) = _CourseSpot;
}