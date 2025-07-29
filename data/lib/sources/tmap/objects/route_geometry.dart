import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_geometry.g.dart';

@JsonSerializable()
class RouteGeometry {
  final String type;
  // Point: [lon, lat], LineString: [[lon, lat], [lon, lat], ...]
  // 두 가지 타입을 모두 처리하기 위해 List<dynamic>으로 선언합니다.
  final List<dynamic> coordinates;

  RouteGeometry({required this.type, required this.coordinates});

  factory RouteGeometry.fromJson(Map<String, dynamic> json) =>
      _$RouteGeometryFromJson(json);

  Map<String, dynamic> toJson() => _$RouteGeometryToJson(this);
}
