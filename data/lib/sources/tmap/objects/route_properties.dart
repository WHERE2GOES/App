import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_properties.g.dart';

@JsonSerializable()
class RouteProperties {
  final int? totalDistance;
  final int? totalTime;
  final int? index;
  final int? pointIndex;
  final String? name;
  final String? description;
  final String? direction;
  @JsonKey(name: 'nearPoiName')
  final String? nearPoiName;
  @JsonKey(name: 'nearPoiX')
  final String? nearPoiX;
  @JsonKey(name: 'nearPoiY')
  final String? nearPoiY;
  @JsonKey(name: 'intersectionName')
  final String? intersectionName;
  @JsonKey(name: 'facilityType')
  final String? facilityType;
  @JsonKey(name: 'facilityName')
  final String? facilityName;
  @JsonKey(name: 'turnType')
  final int? turnType;
  @JsonKey(name: 'pointType')
  final String? pointType;

  RouteProperties({
    this.totalDistance,
    this.totalTime,
    this.index,
    this.pointIndex,
    this.name,
    this.description,
    this.direction,
    this.nearPoiName,
    this.nearPoiX,
    this.nearPoiY,
    this.intersectionName,
    this.facilityType,
    this.facilityName,
    this.turnType,
    this.pointType,
  });

  factory RouteProperties.fromJson(Map<String, dynamic> json) =>
      _$RoutePropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$RoutePropertiesToJson(this);
}
