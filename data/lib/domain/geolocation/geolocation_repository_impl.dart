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
  final TmapApiService tmapApiService;

  const GeolocationRepositoryImpl({
    required this.openapi,
    required this.authPreference,
    required this.tmapApiService,
  });

  @override
  Future<Result<AddressEntity>> getAddress({
    required double latitude,
    required double longitude,
  }) async {
    // TODO: implement getAddress
    return Failure(exception: Exception("Not implemented"));
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
    PlaceCategory? placeCategory,
    int radius = 1000,
    int limit = 50,
  }) async {
    try {
      final courseId = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getCourseControllerApi();
          final response = await api.getCurrentCourse(
            headers: {"Authorization": "Bearer $accessToken"},
          );

          return response.data?.data?.courseId;
        },
      );

      if (courseId == null) throw Exception("코스 ID를 찾을 수 없습니다.");

      final places = await openapi.callWithAuth(
        authPreference: authPreference,
        action: (accessToken) async {
          final api = openapi.getCourseControllerApi();
          final response = await api.getCoursePlaces(
            id: courseId,
            headers: {"Authorization": "Bearer $accessToken"},
          );
          return response.data?.data?.places;
        },
      );

      return Success(
        data:
            places
                ?.map(
                  (e) => PlaceEntity(
                    name: e.name!,
                    category: switch (e.category) {
                      "화장실" => PlaceCategory.toilet,
                      "숙박업소" => PlaceCategory.rest,
                      "음식점" => PlaceCategory.restaurant,
                      _ => PlaceCategory.other,
                    },
                    latitude: e.latitude!,
                    longitude: e.longitude!,
                  ),
                )
                .where(
                  (e) => placeCategory == null || e.category == placeCategory,
                )
                .toList() ??
            [],
      );
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
        startX: startLatitude,
        startY: startLongitude,
        endX: endLatitude,
        endY: endLongitude,
        appKey: '',
        startName: '',
        endName: '',
      );

      final route = response.features
          .map((e) {
            if (e.geometry.type != "LineString") {
              return e.geometry.coordinates.map(
                (e) => RoutePointEntity(
                  latitude: e[0],
                  longitude: e[1],
                  description: null,
                ),
              );
            } else if (e.geometry.type == "Point") {
              return [
                RoutePointEntity(
                  latitude: e.geometry.coordinates[0],
                  longitude: e.geometry.coordinates[1],
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
}
