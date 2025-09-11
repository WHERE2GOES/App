import 'package:core/domain/geolocation/model/place_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_entity.freezed.dart';

@freezed
abstract class PlaceEntity with _$PlaceEntity {
  const factory PlaceEntity({
    required String name,
    required PlaceCategory category,
    required double latitude,
    required double longitude,
  }) = _PlaceEntity;
}
