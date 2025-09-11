import 'package:core/common/result.dart';
import 'package:core/domain/geolocation/model/address_entity.dart';
import 'package:core/domain/geolocation/model/emergency_entity.dart';
import 'package:core/domain/geolocation/model/place_category.dart';
import 'package:core/domain/geolocation/model/place_entity.dart';
import 'package:core/domain/geolocation/model/route_point_entity.dart';

abstract interface class GeolocationRepository {
  /// 주변 장소 목록 조회
  Future<Result<List<PlaceEntity>>> getNearbyPlaces({
    required double latitude,
    required double longitude,
    PlaceCategory? placeCategory,
    int radius = 1000, // 조회 반경 (단위: 미터)
    int limit = 50, // 최대 조회 결과 수
  });

  /// 주소 조회
  Future<Result<AddressEntity>> getAddress({
    required double latitude,
    required double longitude,
  });

  /// 주변 비상 정보 조회
  Future<Result<List<EmergencyEntity>>> getNearbyEmergency({
    required double latitude,
    required double longitude,
  });

  /// 해당 장소까지의 경로 조회
  Future<Result<List<RoutePointEntity>>> getRoute({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  });
}
