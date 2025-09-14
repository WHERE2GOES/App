import 'package:json_annotation/json_annotation.dart';

part 'reverse_geocoding_response.g.dart';

@JsonSerializable()
class ReverseGeocodingResponse {
  final AddressInfo? addressInfo;

  ReverseGeocodingResponse({this.addressInfo});

  factory ReverseGeocodingResponse.fromJson(Map<String, dynamic> json) =>
      _$ReverseGeocodingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReverseGeocodingResponseToJson(this);
}

@JsonSerializable()
class AddressInfo {
  final String? fullAddress;
  final String? addressType;
  @JsonKey(name: 'city_do')
  final String? cityDo;
  @JsonKey(name: 'gu_gun')
  final String? guGun;
  @JsonKey(name: 'eup_myun')
  final String? eupMyun;
  @JsonKey(name: 'adminDong')
  final String? adminDong;
  @JsonKey(name: 'adminDongCode')
  final String? adminDongCode;
  @JsonKey(name: 'legalDong')
  final String? legalDong;
  @JsonKey(name: 'legalDongCode')
  final String? legalDongCode;
  final String? ri;
  final String? bunji;
  final String? roadName;
  @JsonKey(name: 'roadCode')
  final String? roadCode;
  @JsonKey(name: 'buildingIndex')
  final String? buildingIndex;
  @JsonKey(name: 'buildingName')
  final String? buildingName;

  AddressInfo({
    this.fullAddress,
    this.addressType,
    this.cityDo,
    this.guGun,
    this.eupMyun,
    this.adminDong,
    this.adminDongCode,
    this.legalDong,
    this.legalDongCode,
    this.ri,
    this.bunji,
    this.roadName,
    this.roadCode,
    this.buildingIndex,
    this.buildingName,
  });

  factory AddressInfo.fromJson(Map<String, dynamic> json) =>
      _$AddressInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressInfoToJson(this);
}