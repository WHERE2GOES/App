import 'package:freezed_annotation/freezed_annotation.dart';

part 'emergency_entity.freezed.dart';

@freezed
abstract class EmergencyEntity with _$EmergencyEntity {
  const factory EmergencyEntity({
    required String description,
    required double? latitude,
    required double? longitude,
  }) = _EmergencyEntity;
}
