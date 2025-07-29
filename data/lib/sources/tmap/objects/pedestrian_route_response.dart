import 'package:data/sources/tmap/objects/route_feature.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pedestrian_route_response.g.dart';

@JsonSerializable()
class PedestrianRouteResponse {
  final String type;
  final List<RouteFeature> features;

  PedestrianRouteResponse({required this.type, required this.features});

  factory PedestrianRouteResponse.fromJson(Map<String, dynamic> json) =>
      _$PedestrianRouteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PedestrianRouteResponseToJson(this);
}
