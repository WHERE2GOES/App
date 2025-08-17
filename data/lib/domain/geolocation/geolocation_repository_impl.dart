import 'package:core/common/result.dart';
import 'package:core/domain/geolocation/geolocation_repository.dart';
import 'package:core/domain/geolocation/model/address_entity.dart';
import 'package:core/domain/geolocation/model/emergency_entity.dart';
import 'package:core/domain/geolocation/model/place_category.dart';
import 'package:core/domain/geolocation/model/place_entity.dart';
import 'package:core/domain/geolocation/model/route_point_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GeolocationRepository)
class GeolocationRepositoryImpl implements GeolocationRepository {
  const GeolocationRepositoryImpl();

  @override
  Future<Result<AddressEntity>> getAddress({
    required double latitude,
    required double longitude,
  }) {
    // TODO: implement getAddress
    throw UnimplementedError();
  }

  @override
  Future<Result<List<EmergencyEntity>>> getNearbyEmergency({
    required double latitude,
    required double longitude,
  }) {
    // TODO: implement getNearbyEmergency
    throw UnimplementedError();
  }

  @override
  Future<Result<List<PlaceEntity>>> getNearbyPlaces({
    required double latitude,
    required double longitude,
    required PlaceCategory placeCategory,
    int radius = 1000,
    int limit = 50,
  }) {
    // TODO: implement getNearbyPlaces
    throw UnimplementedError();
  }

  @override
  Future<Result<List<RoutePointEntity>>> getRoute({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    // TODO: implement getRoute
    throw UnimplementedError();
  }
}
