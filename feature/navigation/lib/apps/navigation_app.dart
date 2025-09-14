import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navigation/models/place_prop.dart';
import 'package:navigation/models/place_type.dart';
import 'package:navigation/models/route_guidance_item_prop.dart';
import 'package:navigation/screens/navigation_map_screen.dart';
import 'package:navigation/screens/navigation_nearby_place_screen.dart';
import 'package:navigation/utils/determine_position.dart';
import 'package:navigation/vms/navigation_view_model.dart';

class NavigationApp extends StatefulWidget {
  const NavigationApp({super.key, required this.vm, required this.onBack});

  final NavigationViewModel vm;
  final VoidCallback onBack;

  @override
  State<StatefulWidget> createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  InAppWebViewController? mapController;
  bool _shouldShowNearbyPlacePopup = false;
  StreamSubscription<Position>? _positionStream;

  @override
  void initState() {
    super.initState();

    _positionStream =
        Geolocator.getPositionStream(
          locationSettings: LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 100,
          ),
        ).listen((Position? position) {
          if (position == null) return;
          _updatedCurrentPosition(
            latitude: position.latitude,
            longitude: position.longitude,
          );
        });

    widget.vm.startNavigation().then((_) {
      _markRouteToMap(
        positions: widget.vm.route!
            .map((e) => (latitude: e.latitude, longitude: e.longitude))
            .toList(),
      );
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return BackButtonListener(
              onBackButtonPressed: () async {
                _back();
                return true;
              },
              child: ListenableBuilder(
                listenable: widget.vm,
                builder: (context, child) {
                  return switch (settings.name) {
                    '/' => _buildNavigationMapScreen(),
                    '/nearby-place' => _buildNavigationNearbyPlaceScreen(),
                    _ => throw Exception("Invalid route"),
                  };
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildNavigationMapScreen() {
    return NavigationMapScreen(
      mapWidget: InAppWebView(onWebViewCreated: _onMapWebViewCreated),
      tutorial: null,
      totalTravelTime: Duration(),
      nearbyPlacePopup: _shouldShowNearbyPlacePopup
          ? (
              buttons: PlaceType.values
                  .map(
                    (placeType) => (
                      imageAsset: placeType.imageAsset,
                      onClicked: () => _onNearbyPlacePopupButtonClicked(
                        placeType: placeType,
                      ),
                    ),
                  )
                  .toList(),
              onDismissed: () =>
                  setState(() => _shouldShowNearbyPlacePopup = false),
            )
          : null,
      destinationName: widget.vm.selectedPlace?.name ?? "",
      routeGuidanceItems: widget.vm.routeToPlace
          ?.where((e) => e.description != null)
          .map(
            (e) => (
              description: e.description!,
              routeGuidanceType: RouteGuidanceType.straight,
            ),
          )
          .toList(),
      onTimerClicked: () {},
      onMenuButtonClicked: () => setState(
        () => _shouldShowNearbyPlacePopup = !_shouldShowNearbyPlacePopup,
      ),
      onEmergencyButtonClicked: () {},
      onGoToCurrentLocationButtonClicked: _moveMapToCurrentPosition,
    );
  }

  Widget _buildNavigationNearbyPlaceScreen() {
    final selectedPlaceType = widget.vm.selectedPlaceType;
    final nearbyPlaces = selectedPlaceType != null
        ? widget.vm.nearbyPlaces[selectedPlaceType]
        : null;

    return NavigationNearbyPlaceScreen(
      placeCagetoryButtons: PlaceType.values
          .map(
            (placeType) => (
              name: placeType.label,
              onClicked: () async {
                final position = await determinePosition();

                widget.vm.selectPlaceType(
                  placeType: placeType,
                  latitude: position.latitude,
                  longitude: position.longitude,
                );
              },
            ),
          )
          .toList(),
      selectedPlaceType: selectedPlaceType,
      places:
          nearbyPlaces
              ?.map(
                (e) => (
                  distance: 100,
                  name: e.name,
                  isHighligted: true,
                  placeDetailIcon: PlaceDetailIcon.pin,
                  placeClickingBahaviorText:
                      PlaceClickingBahaviorText.findRoute,
                  likeCount: 100,
                  isLiked: false,
                  onClicked: () {
                    widget.vm.selectPlace(place: e).then((_) {
                      _markRouteToMap(
                        positions: widget.vm.routeToPlace!
                            .map(
                              (e) => (
                                latitude: e.latitude,
                                longitude: e.longitude,
                              ),
                            )
                            .toList(),
                      );
                    });
                    _back();
                  },
                  onLikeButtonClicked: () {},
                ),
              )
              .toList() ??
          [],
      shouldShowLoadingIndicatorAtBottom: false,
      onLastPlaceRendered: () {},
    );
  }

  void _back() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      _navigatorKey.currentState?.pop();
    } else {
      widget.onBack();
    }
  }

  void _onMapWebViewCreated(InAppWebViewController controller) {
    controller
        .loadUrl(
          urlRequest: URLRequest(
            url: WebUri("https://where-to-goes-navigation.netlify.app"),
          ),
        )
        .then((_) async {
          await Future.delayed(const Duration(seconds: 2));
          _moveMapToCurrentPosition();
        });

    setState(() => mapController = controller);
  }

  void _updatedCurrentPosition({
    required double latitude,
    required double longitude,
  }) async {
    mapController?.evaluateJavascript(
      source: [
        "window.updateMyLocation(",
        latitude.toString(),
        ",",
        longitude.toString(),
        ");",
      ].join(),
    );
  }

  void _moveMapToCurrentPosition() async {
    final currentLocation = await determinePosition();

    mapController?.evaluateJavascript(
      source: [
        "window.panMapTo(",
        currentLocation.latitude.toString(),
        ",",
        currentLocation.longitude.toString(),
        ");",
      ].join(),
    );
  }

  void _markRouteToMap({
    required List<({double latitude, double longitude})> positions,
  }) {
    mapController?.evaluateJavascript(
      source: [
        "window.markRoute([",
        positions
            .map(
              (position) =>
                  "{ lat: ${position.latitude}, lng: ${position.longitude} }",
            )
            .join(","),
        "]);",
      ].join(),
    );
  }

  void _onNearbyPlacePopupButtonClicked({required PlaceType placeType}) async {
    setState(() {
      _shouldShowNearbyPlacePopup = false;
    });

    final position = await determinePosition();

    widget.vm.selectPlaceType(
      placeType: placeType,
      latitude: position.latitude,
      longitude: position.longitude,
    );

    _navigatorKey.currentState?.pushNamed("/nearby-place");
  }
}
