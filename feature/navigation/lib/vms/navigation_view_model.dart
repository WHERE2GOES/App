import 'package:core/common/result.dart';
import 'package:core/domain/course/course_repository.dart';
import 'package:core/domain/course/model/course_route_point_entity.dart';
import 'package:core/domain/course/model/current_course_entity.dart';
import 'package:core/domain/geolocation/geolocation_repository.dart';
import 'package:core/domain/geolocation/model/place_category.dart';
import 'package:core/domain/geolocation/model/place_entity.dart';
import 'package:core/domain/geolocation/model/route_point_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:navigation/models/place_type.dart';

@lazySingleton
class NavigationViewModel extends ChangeNotifier {
  final CourseRepository courseRepository;
  final GeolocationRepository geolocationRepository;

  NavigationViewModel({
    required this.courseRepository,
    required this.geolocationRepository,
  });

  CurrentCourseEntity? currentCourse;
  List<CourseRoutePointEntity>? route;
  PlaceType? selectedPlaceType;
  PlaceEntity? selectedPlace;
  List<RoutePointEntity>? routeToPlace;
  Map<PlaceType, List<PlaceEntity>?> nearbyPlaces = {
    for (var e in PlaceType.values) e: null,
  };

  Future<void> startNavigation() async {
    final currentCourseResponse = await courseRepository.getCurrentCourse();
    if (currentCourseResponse is! Success<CurrentCourseEntity?>) return;

    final currentCourseData = currentCourseResponse.data;
    if (currentCourseData == null) return;

    currentCourse = currentCourseData;
    notifyListeners();

    final routeResponse = await courseRepository.getCourseRoute(
      courseId: currentCourseData.id,
    );

    if (routeResponse is! Success<List<CourseRoutePointEntity>>) return;

    route = routeResponse.data;
    notifyListeners();
  }

  Future<void> selectPlaceType({
    required PlaceType placeType,
    required double latitude,
    required double longitude,
  }) async {
    selectedPlaceType = placeType;
    nearbyPlaces[placeType] = null;
    notifyListeners();

    final nearbyPlacesResponse = await geolocationRepository.getNearbyPlaces(
      latitude: latitude,
      longitude: longitude,
      placeCategory: switch (placeType) {
        PlaceType.restaurant => PlaceCategory.restaurant,
        PlaceType.accommodation => PlaceCategory.rest,
        PlaceType.restroom => PlaceCategory.toilet,
      },
    );

    if (nearbyPlacesResponse is! Success<List<PlaceEntity>>) return;

    nearbyPlaces[placeType] = nearbyPlacesResponse.data;
    notifyListeners();
  }

  Future<void> selectPlace({required PlaceEntity place}) async {
    selectedPlace = place;
    routeToPlace = null;
    notifyListeners();

    final routeResponse = await geolocationRepository.getRoute(
      startLatitude: place.latitude,
      startLongitude: place.longitude,
      endLatitude: place.latitude,
      endLongitude: place.longitude,
    );

    if (routeResponse is! Success<List<RoutePointEntity>>) return;

    routeToPlace = routeResponse.data;
    notifyListeners();
  }
}
