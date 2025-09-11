import 'package:core/common/result.dart';
import 'package:core/domain/geolocation/geolocation_repository.dart';
import 'package:core/domain/geolocation/model/address_entity.dart';
import 'package:core/domain/geolocation/model/emergency_entity.dart';
import 'package:core/domain/geolocation/model/place_category.dart';
import 'package:core/domain/geolocation/model/place_entity.dart';
import 'package:core/domain/geolocation/model/route_point_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:data/sources/local/auth_preference.dart';
import 'package:data/utils/call_with_auth.dart';
import 'package:openapi/openapi.dart';

@LazySingleton(as: GeolocationRepository)
class GeolocationRepositoryImpl implements GeolocationRepository {
  final Openapi openapi;
  final AuthPreference authPreference;

  const GeolocationRepositoryImpl({
    required this.openapi,
    required this.authPreference,
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
          final response = await api.getCoursePlaces(id: courseId);
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
    // TODO: implement getRoute
    return Failure(exception: Exception("Not implemented"));
  }
}
