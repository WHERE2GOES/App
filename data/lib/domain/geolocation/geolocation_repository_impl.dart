import 'dart:math';

import 'package:core/common/result.dart';
import 'package:core/domain/geolocation/geolocation_repository.dart';
import 'package:core/domain/geolocation/model/address_entity.dart';
import 'package:core/domain/geolocation/model/emergency_entity.dart';
import 'package:core/domain/geolocation/model/place_category.dart';
import 'package:core/domain/geolocation/model/place_entity.dart';
import 'package:core/domain/geolocation/model/route_point_entity.dart';
import 'package:data/sources/tmap/services/tmap_api_service.dart';
import 'package:injectable/injectable.dart';
import 'package:data/sources/local/auth_preference.dart';
import 'package:data/utils/call_with_auth.dart';
import 'package:openapi/openapi.dart';

@LazySingleton(as: GeolocationRepository)
class GeolocationRepositoryImpl implements GeolocationRepository {
  final Openapi openapi;
  final AuthPreference authPreference;
  final String tmapApiKey;
  final TmapApiService tmapApiService;

  const GeolocationRepositoryImpl({
    required this.openapi,
    required this.authPreference,
    @Named("tmap_api_key") required this.tmapApiKey,
    required this.tmapApiService,
  });

  @override
  Future<Result<AddressEntity>> getAddress({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await tmapApiService.getReverseGeocoding(
        lat: latitude,
        lon: longitude,
        appKey: tmapApiKey,
      );

      return Success(
        data: AddressEntity(
          city: response.addressInfo!.cityDo!,
          full: response.addressInfo!.fullAddress!,
        ),
      );
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<List<EmergencyEntity>>> getNearbyEmergency({
    required double latitude,
    required double longitude,
  }) async {
    // TODO: implement getNearbyEmergency
    return Failure(exception: Exception("Not implemented"));
  }

  @override
  Future<Result<List<PlaceEntity>>> getNearbyPlaces({
    required double latitude,
    required double longitude,
    required PlaceCategory placeCategory,
    int radius = 1000,
    int limit = 50,
  }) async {
    try {
      final address = await getAddress(
        latitude: latitude,
        longitude: longitude,
      );

      if (address is! Success<AddressEntity>) throw Exception("주소를 찾을 수 없습니다.");

      final response = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getFestivalControllerApi();

          final response = switch (placeCategory) {
            PlaceCategory.rest => await api.getHotel(
              areaName: address.data.city,
              headers: {"Authorization": "Bearer $accessToken"},
            ),
            PlaceCategory.restaurant => await api.getFood(
              areaName: address.data.city,
              headers: {"Authorization": "Bearer $accessToken"},
            ),
            _ => throw Exception("Not implemented"),
          };

          return response.data!.data!.asList();
        },
      );

      final result = response
          .map(
            (e) => PlaceEntity(
              name: e.title!,
              category: placeCategory,
              latitude: double.parse(e.mapy!),
              longitude: double.parse(e.mapx!),
            ),
          )
          .toList();

      result.sort(
        (a, b) =>
            getDistance(
                  aLatitude: a.latitude,
                  aLongitude: a.longitude,
                  bLatitude: latitude,
                  bLongitude: longitude,
                ) <
                getDistance(
                  aLatitude: b.latitude,
                  aLongitude: b.longitude,
                  bLatitude: latitude,
                  bLongitude: longitude,
                )
            ? 1
            : -1,
      );

      return Success(data: result);
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  @override
  Future<Result<List<RoutePointEntity>>> getRoute({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) async {
    try {
      final response = await tmapApiService.getPedestrianRoute(
        startX: startLongitude,
        startY: startLatitude,
        endX: endLongitude,
        endY: endLatitude,
        appKey: tmapApiKey,
        startName: 'start',
        endName: 'end',
      );

      final route = response.features
          .map((e) {
            if (e.geometry.type == "LineString") {
              return e.geometry.coordinates.map(
                (e) => RoutePointEntity(
                  latitude: e[1],
                  longitude: e[0],
                  description: null,
                ),
              );
            } else if (e.geometry.type == "Point") {
              return [
                RoutePointEntity(
                  latitude: e.geometry.coordinates[1],
                  longitude: e.geometry.coordinates[0],
                  description: e.properties.description,
                ),
              ];
            } else {
              return null;
            }
          })
          .whereType<Iterable<RoutePointEntity>>()
          .expand((e) => e)
          .toList();

      return Success(data: route);
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }

  double getDistance({
    required double aLatitude,
    required double aLongitude,
    required double bLatitude,
    required double bLongitude,
  }) {
    return sqrt(
      pow(aLatitude - bLatitude, 2) + pow(aLongitude - bLongitude, 2),
    );
  }
}
