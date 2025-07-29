import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_point_entity.freezed.dart';

@freezed
abstract class RoutePointEntity with _$RoutePointEntity {
  const factory RoutePointEntity({
    required double latitude,
    required double longitude,
    required String? description,
  }) = _RoutePointEntity;
}
