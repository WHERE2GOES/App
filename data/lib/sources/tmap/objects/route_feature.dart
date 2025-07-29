import 'package:data/sources/tmap/objects/route_geometry.dart';
import 'package:data/sources/tmap/objects/route_properties.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_feature.g.dart';

@JsonSerializable()
class RouteFeature {
  final String type;
  final RouteGeometry geometry;
  final RouteProperties properties;

  RouteFeature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  factory RouteFeature.fromJson(Map<String, dynamic> json) =>
      _$RouteFeatureFromJson(json);

  Map<String, dynamic> toJson() => _$RouteFeatureToJson(this);
}
